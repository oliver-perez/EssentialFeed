//
//  FeedImagesMapper.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 26/10/20.
//

import Foundation

final class FeedImagesMapper {
  private struct Root: Decodable {
    let items: [RemoteFeedImage]
  }
    
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedImage] {
    guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
      throw RemoteFeedLoader.Error.invalidData
    }
    return root.items
  }
}

