//
//  CodableFeedStore.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 19/01/21.
//

import Foundation

public class CodableFeedStore: FeedStore {
  
  private struct Cache: Codable {
    let feed: [CodableFeedImage]
    let timestamp: Date
    
    var localFeed: [LocalFeedImage] {
      feed.map { $0.local }
    }
  }
  
  private struct CodableFeedImage: Codable {
    private let id: UUID
    private let description: String?
    private let location: String?
    private let url: URL
    
    init(_ image: LocalFeedImage) {
      id = image.id
      description = image.description
      location = image.location
      url = image.url
    }
    
    var local: LocalFeedImage {
      LocalFeedImage(id: id,
                     description: description,
                     location: location,
                     url: url)
    }
  }
  
  private let queue = DispatchQueue(label: "\(CodableFeedStore.self)Queue",
                                    qos: .userInitiated,
                                    attributes: .concurrent)
  private let storeURL: URL
  
  public init(storeURL: URL) {
    self.storeURL = storeURL
  }
  
  public func retrieve(completion: @escaping RetrievalCompletion) {
    queue.async { [storeURL] in
      guard let data = try? Data(contentsOf: storeURL) else {
        return completion(.success(.none))
      }
      
      do {
        let decoder = JSONDecoder()
        let cache = try decoder.decode(Cache.self, from: data)
        completion(.success(CachedFeed(feed: cache.localFeed, timestamp: cache.timestamp)))
      } catch {
        completion(.failure(error))
      }
    }
  }
  
  public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
    queue.async(flags: .barrier) { [storeURL] in
      do {
        let encoder = JSONEncoder()
        let cache = Cache(feed: feed.map(CodableFeedImage.init), timestamp: timestamp)
        let encoded = try encoder.encode(cache)
        try encoded.write(to: storeURL)
        completion(.success(()))
      } catch {
        completion(.failure(error))
      }
    }
  }
  
  public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
    queue.async(flags: .barrier) { [storeURL] in
      guard FileManager.default.fileExists(atPath: storeURL.path) else {
        return completion(.success(()))
      }
      do {
        try FileManager.default.removeItem(at: storeURL)
        completion(.success(()))
      } catch {
        completion(.failure(error))
      }
    }
  }
}
