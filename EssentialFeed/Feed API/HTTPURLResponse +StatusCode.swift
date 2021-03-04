//
//  HTTPURLResponse +StatusCode.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 03/03/21.
//

import Foundation

extension HTTPURLResponse {
  private static var OK_200: Int { return 200 }

  var isOK: Bool {
    return statusCode == HTTPURLResponse.OK_200
  }
}
