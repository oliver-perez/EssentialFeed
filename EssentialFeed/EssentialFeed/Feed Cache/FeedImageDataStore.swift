//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 05/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public protocol FeedImageDataStore {
  typealias RetrievalResult = Swift.Result<Data?, Error>
  typealias InsertionResult = Swift.Result<Void, Error>

  func insert(_ data: Data, for url: URL, completion: @escaping (InsertionResult) -> Void)
  func retrieve(dataForURL url: URL, completion: @escaping (RetrievalResult) -> Void)
}

