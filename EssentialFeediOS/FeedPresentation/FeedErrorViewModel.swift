//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 24/02/21.
//

struct FeedErrorViewModel {
  let message: String?
  
  static var noError: FeedErrorViewModel {
    return FeedErrorViewModel(message: nil)
  }
  
  static func error(message: String) -> FeedErrorViewModel {
    return FeedErrorViewModel(message: message)
  }
}
