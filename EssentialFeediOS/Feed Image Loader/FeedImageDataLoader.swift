//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 05/02/21.
//

import Foundation

public protocol FeedImageDataLoaderTask {
  func cancel()
}

public protocol FeedImageDataLoader {
  typealias Result = Swift.Result<Data, Error>
  
  func loadImageData(from url: URL, completion: @escaping(Result) -> Void) -> FeedImageDataLoaderTask
}
