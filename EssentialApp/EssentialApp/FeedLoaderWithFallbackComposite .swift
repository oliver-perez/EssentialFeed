//
//  FeedLoaderWithFallbackComposite .swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 07/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import EssentialFeed

public class FeedLoaderWithFallbackComposite: FeedLoader {
  private let primary: FeedLoader
  private let fallback: FeedLoader

  public init(primary: FeedLoader, fallback: FeedLoader) {
    self.primary = primary
    self.fallback = fallback
  }

  public func load(completion: @escaping (FeedLoader.Result) -> Void) {
    primary.load { [weak self] result in
      switch result {
      case .success:
        completion(result)

      case .failure:
        self?.fallback.load(completion: completion)
      }
    }
  }
}
