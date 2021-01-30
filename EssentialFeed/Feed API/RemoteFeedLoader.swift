//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 23/10/20.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
  
  private let client: HTTPClient
  private let url: URL
  
  public enum Error: Swift.Error {
    case connectivity
    case invalidData
  }
  
  public typealias Result = FeedLoader.Result
  
  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }
  
  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { [weak self] result in
      guard self != nil else { return }
      switch result {
      case let .success(data, response):
        completion(Self.map(data, from: response))
      case .failure:
        completion(.failure(Error.connectivity))
      }
    }
  }
  
  private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
    do {
      let items = try FeedImagesMapper.map(data, from: response)
      return .success(items.toModels())
    } catch {
      return .failure(error)
    }
  }
  
}

private extension Array where Element == RemoteFeedImage {
  func toModels() -> [FeedImage] {
    map {
      FeedImage(id: $0.id,
               description: $0.description,
               location: $0.location,
               url: $0.image) }
  }
}
