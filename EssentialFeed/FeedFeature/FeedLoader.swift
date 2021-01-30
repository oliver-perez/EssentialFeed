//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 19/10/20.
//

import Foundation

public protocol FeedLoader {
  typealias Result = Swift.Result<[FeedImage], Error>
  
  func load(completion: @escaping (Result) -> Void)
}
