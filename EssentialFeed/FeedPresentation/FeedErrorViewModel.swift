//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 26/02/21.
//

public struct FeedErrorViewModel {
  public let message: String?
  
  static var noError: FeedErrorViewModel {
    return FeedErrorViewModel(message: nil)
  }
  
  static func error(message: String) -> FeedErrorViewModel {
    return FeedErrorViewModel(message: message)
  }
}
