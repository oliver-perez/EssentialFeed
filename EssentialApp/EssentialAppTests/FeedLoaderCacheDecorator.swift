//
//  FeedLoaderCacheDecorator.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 08/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import XCTest
import EssentialFeed

final class FeedLoaderCacheDecorator: FeedLoader {
  private let decoratee: FeedLoader

  init(decoratee: FeedLoader) {
    self.decoratee = decoratee
  }

  func load(completion: @escaping (FeedLoader.Result) -> Void) {
    decoratee.load(completion: completion)
  }
}

class FeedLoaderCacheDecoratorTests: XCTestCase, FeedLoaderTestCase {

  func test_load_deliversFeedOnLoaderSuccess() {
    let feed = uniqueFeed()
    let loader = FeedLoaderStub(result: .success(feed))
    let sut = FeedLoaderCacheDecorator(decoratee: loader)

    expect(sut, toCompleteWith: .success(feed))
  }

  func test_load_deliversErrorOnLoaderFailure() {
    let loader = FeedLoaderStub(result: .failure(anyNSError()))
    let sut = FeedLoaderCacheDecorator(decoratee: loader)

    expect(sut, toCompleteWith: .failure(anyNSError()))
  }

}
