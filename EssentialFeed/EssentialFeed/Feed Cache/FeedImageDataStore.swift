//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 05/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public protocol FeedImageDataStore {
  typealias Result = Swift.Result<Data?, Error>

  func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
