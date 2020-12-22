//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 26/10/20.
//

import Foundation

internal final class FeedItemsMapper {
  private struct Root: Decodable {
    let items: [RemoteFeedItem]
  }
  
  internal static var OK_200: Int { 200 }
  
  internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
    guard response.statusCode == OK_200,
          let root = try? JSONDecoder().decode(Root.self, from: data) else {
      throw RemoteFeedLoader.Error.invalidData
    }
    return root.items
  }
}

