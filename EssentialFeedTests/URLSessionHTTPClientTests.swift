//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Oliver Jordy Pérez Escamilla on 02/11/20.
//

import XCTest
import EssentialFeed

class URLSessionHTTPClientTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    URLProtocolStub.startInterceptingRequests()
  }
  
  override func tearDown() {
    URLProtocolStub.stopInterceptingRequests()
    super.tearDown()
  }
  
  func test_getFromURL_performsGETRequestWithURL() {
    let url = anyURL()
    let requestExpectation = expectation(description: "Wait for request")

    URLProtocolStub.observeRequests { request in
      XCTAssertEqual(request.url, url)
      XCTAssertEqual(request.httpMethod, "GET")
      requestExpectation.fulfill()
    }
    
    makeSUT().get(from: url) { _ in }
    
    wait(for: [requestExpectation], timeout: 1.0)
  }
  
  func test_getFromURL_failsOnRequestError() {
    let requestError = anyNSError()
    let receivedError = resultErrorFor(data: nil, response: nil, error: requestError) as NSError?
    
    XCTAssertEqual(receivedError?.domain, requestError.domain)
    XCTAssertEqual(receivedError?.code, requestError.code)
  }
  
  func test_getFromURL_failsOnAllInvalidRepresentationCases() {
    XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
    XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPResponse(), error: nil))
    XCTAssertNotNil(resultErrorFor(data: anyData(), response: nil, error: nil))
    XCTAssertNotNil(resultErrorFor(data: anyData(), response: nil, error: anyNSError()))
    XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPResponse(), error: anyNSError()))
    XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPResponse(), error: anyNSError()))
    XCTAssertNotNil(resultErrorFor(data: anyData(), response: nonHTTPResponse(), error: anyNSError()))
    XCTAssertNotNil(resultErrorFor(data: anyData(), response: anyHTTPResponse(), error: anyNSError()))
    XCTAssertNotNil(resultErrorFor(data: anyData(), response: nonHTTPResponse(), error: nil))
  }

  func test_getFromURL_succeedsOnHTTPURLResponseWithData() {
    let data = anyData()
    let response = anyHTTPResponse()
    
    let resultValues = resultValuesFor(data: data, response: response, error: nil)
    
    XCTAssertEqual(resultValues?.data, data)
    XCTAssertEqual(resultValues?.response.url, response?.url)
    XCTAssertEqual(resultValues?.response.statusCode, response?.statusCode)
  }
  
  func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
    let response = anyHTTPResponse()
    
    let resultValues = resultValuesFor(data: nil, response: response, error: nil)

    let emptyData = Data()
    XCTAssertEqual(resultValues?.data, emptyData)
    XCTAssertEqual(resultValues?.response.url, response?.url)
    XCTAssertEqual(resultValues?.response.statusCode, response?.statusCode)
  }
  
  // MARK: - Helpers
  
  private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
    let sut = URLSessionHTTPClient()
    trackForMemoryLeaks(sut, file: file, line: line)
    return sut
  }
  
  private func resultValuesFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
    let result = resultFor(data: data, response: response, error: error, file: file, line: line)
    
    switch result {
    case let .success(data, response):
      return (data, response)
    default:
      XCTFail("Expected success, got \(result) instead", file: file, line: line)
      return nil
    }
  }
  
  private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> Error? {
    let result = resultFor(data: data, response: response, error: error, file: file, line: line)
    
    switch result {
    case let .failure(error):
      return error
    default:
      XCTFail("Expected failure, got \(result) instead", file: file, line: line)
      return nil
    }
    
  }

  private func resultFor(data: Data?, response: URLResponse?, error: Error?, file: StaticString = #filePath, line: UInt = #line) -> HTTPClientResult {
    URLProtocolStub.stub(data: data, response: response, error: error)
    let sut = makeSUT(file: file, line: line)
    let exp = expectation(description: "Wait for completion")
    
    var receivedResult: HTTPClientResult!
    sut.get(from: anyURL()) { result in
      receivedResult = result
      exp.fulfill()
    }
    wait(for: [exp], timeout: 1.0)
    
    return receivedResult
  }
  
  private func anyURL() -> URL {
    URL(string: "http://any-url.com")!
  }
  
  private func anyData() -> Data {
    Data("any data".utf8)
  }
  
  private func anyNSError() -> NSError {
    NSError(domain: "any error", code: .zero)
  }
  
  private func anyHTTPResponse() -> HTTPURLResponse? {
    HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)
  }
  
  private func nonHTTPResponse() -> URLResponse {
    URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: .zero, textEncodingName: nil)
  }
  
  private class URLProtocolStub: URLProtocol {
    private static var stub: Stub?
    private static var requestObserver: ((URLRequest) -> Void)?
    
    private struct Stub {
      let data: Data?
      let response: URLResponse?
      let error: Error?
    }
    
    static func stub(data: Data?, response: URLResponse?, error: Error?) {
      stub = Stub(data: data, response: response, error: error)
    }
    
    static func startInterceptingRequests() {
      URLProtocol.registerClass(URLProtocolStub.self)
    }
    
    static func stopInterceptingRequests() {
      URLProtocol.unregisterClass(URLProtocolStub.self)
      stub = nil
      requestObserver = nil
    }
    
    static func observeRequests(observer: @escaping (URLRequest) -> Void) {
      requestObserver = observer
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
      return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
      return request
    }
    
    override func startLoading() {
      if let requestObserver = URLProtocolStub.requestObserver {
        client?.urlProtocolDidFinishLoading(self)
        return requestObserver(request)
      }
      
      if let data = URLProtocolStub.stub?.data {
        client?.urlProtocol(self, didLoad: data)
      }
      
      if let response = URLProtocolStub.stub?.response {
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      }
      
      if let error = URLProtocolStub.stub?.error {
        client?.urlProtocol(self, didFailWithError: error)
      }
      
      client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
  }
  
}
