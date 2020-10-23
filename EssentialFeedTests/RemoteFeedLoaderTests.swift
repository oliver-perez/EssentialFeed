//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Oliver Jordy Pérez Escamilla on 23/10/20.
//

import XCTest

final class RemoteFeedLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
}
