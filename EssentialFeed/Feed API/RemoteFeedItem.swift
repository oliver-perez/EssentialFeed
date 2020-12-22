//
//  RemoteFeedImage.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 21/12/20.
//

import Foundation

internal struct RemoteFeedImage: Decodable {
  internal let id: UUID
  internal let description: String?
  internal let location: String?
  internal let image: URL
}
