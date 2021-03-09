//
//  FeedLoaderStub.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 08/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import EssentialFeed

class FeedLoaderStub: FeedLoader {
  private let result: FeedLoader.Result

  init(result: FeedLoader.Result) {
    self.result = result
  }

  func load(completion: @escaping (FeedLoader.Result) -> Void) {
    completion(result)
  }
}
