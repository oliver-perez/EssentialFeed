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
  
  static var OK_200: Int { 200 }
  
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedImage] {
    guard response.statusCode == OK_200,
          let root = try? JSONDecoder().decode(Root.self, from: data) else {
      throw RemoteFeedLoader.Error.invalidData
    }
    return root.items
  }
}

