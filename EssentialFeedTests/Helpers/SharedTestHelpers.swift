//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Oliver Jordy Pérez Escamilla on 27/12/20.
//

import Foundation

func anyNSError() -> NSError {
  NSError(domain: "any error", code: .zero)
}

func anyURL() -> URL {
  URL(string: "http://any-url.com")!
}

func anyData() -> Data {
  return Data("any data".utf8)
}
