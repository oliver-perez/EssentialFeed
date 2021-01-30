//
//  RemoteFeedImage.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 21/12/20.
//

import Foundation

struct RemoteFeedImage: Decodable {
  let id: UUID
  let description: String?
  let location: String?
  let image: URL
}
