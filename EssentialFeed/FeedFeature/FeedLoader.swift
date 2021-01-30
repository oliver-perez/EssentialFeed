//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 19/10/20.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
