//
//  FeedViewModel.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 07/02/21.
//

import Foundation
import EssentialFeed

protocol FeedLoadingView {
  func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
  func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
  typealias Observer<T> = (T) -> Void
  
  private let feedView: FeedView
  private let loadingView: FeedLoadingView
  
  init(feedView: FeedView, loadingView: FeedLoadingView) {
    self.feedView = feedView
    self.loadingView = loadingView
  }
  
  static var title: String {
    "My Feed"
  }
  
  func didStartLoadingFeed() {
    loadingView.display(FeedLoadingViewModel(isLoading: true))
  }
  
  func didFinishLoadingFeed(with feed: [FeedImage]) {
    feedView.display(FeedViewModel(feed: feed))
    loadingView.display(FeedLoadingViewModel(isLoading: false))
  }
  
  func didFinishLoading(with error: Error) {
    loadingView.display(FeedLoadingViewModel(isLoading: false))
  }
  
}

