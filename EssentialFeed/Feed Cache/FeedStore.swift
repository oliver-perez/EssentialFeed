//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 20/12/20.
//

import Foundation

public enum RetrieveCacheFeedResult {
  case empty
  case found(feed: [LocalFeedImage], timestamp: Date)
  case failure(Error)
}

public protocol FeedStore {
  typealias DeletionCompletion = (Error?) -> Void
  typealias InsertionCompletion = (Error?) -> Void
  typealias RetrievalCompletion = (RetrieveCacheFeedResult) -> Void
  
  func deleteCachedFeed(completion: @escaping DeletionCompletion)
  func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
  func retrieve(completion: @escaping RetrievalCompletion)
}
