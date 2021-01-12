//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 11/01/21.
//

import Foundation

internal final class FeedCachePolicy {
  private init() {}
  
  private static let calendar = Calendar(identifier: .gregorian)
  
  private static var maxCacheAgeInDays: Int { 7 }
  
  internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
    guard let maxCache = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else { return false }
    return date < maxCache
  }
}
