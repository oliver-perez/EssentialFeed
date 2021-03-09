//
//  XCTestCase+FeedLoader.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 08/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

protocol FeedLoaderTestCase: XCTestCase {}

extension FeedLoaderTestCase {
  func expect(_ sut: FeedLoader, toCompleteWith expectedResult: FeedLoader.Result, file: StaticString = #file, line: UInt = #line) {
    let exp = expectation(description: "Wait for load completion")

    sut.load { receivedResult in
      switch (receivedResult, expectedResult) {
      case let (.success(receivedFeed), .success(expectedFeed)):
        XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)

      case (.failure, .failure):
        break

      default:
        XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
      }

      exp.fulfill()
    }

    wait(for: [exp], timeout: 1.0)
  }
}
