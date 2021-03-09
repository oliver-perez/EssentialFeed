//
//  SharedTestHelpers.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 07/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation
import EssentialFeed

func anyNSError() -> NSError {
  return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
  return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
  return Data("any data".utf8)
}

func uniqueFeed() -> [FeedImage] {
  return [FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())]
}
