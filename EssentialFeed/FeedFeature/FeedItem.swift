//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 19/10/20.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
