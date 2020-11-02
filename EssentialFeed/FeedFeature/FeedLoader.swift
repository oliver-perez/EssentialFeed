//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 19/10/20.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
