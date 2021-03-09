//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 08/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

public protocol FeedCache {
  typealias Result = Swift.Result<Void, Error>

  func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
