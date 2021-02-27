//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 26/02/21.
//

import Foundation

public protocol FeedView {
  func display(_ viewModel: FeedViewModel)
}

public protocol FeedLoadingView {
  func display(_ viewModel: FeedLoadingViewModel)
}

public struct FeedErrorViewModel {
  public let message: String?
  
  static var noError: FeedErrorViewModel {
    return FeedErrorViewModel(message: nil)
  }
  
  static func error(message: String) -> FeedErrorViewModel {
    return FeedErrorViewModel(message: message)
  }
}

public protocol FeedErrorView {
  func display(_ viewModel: FeedErrorViewModel)
}

public final class FeedPresenter {
  private let feedView: FeedView
  private let errorView: FeedErrorView
  private let loadingView: FeedLoadingView
  
  public static var title: String {
    NSLocalizedString("FEED_VIEW_TITLE",
                      tableName: "Feed",
                      bundle: Bundle(for: FeedPresenter.self),
                      comment: "Title for the feed view")
  }
  
  private var feedLoadError: String {
    return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
                             tableName: "Feed",
                             bundle: Bundle(for: FeedPresenter.self),
                             comment: "Error message displayed when we can't load the image feed from the server")
  }
  
  public init(feedView: FeedView, errorView: FeedErrorView, loadingView: FeedLoadingView) {
    self.feedView = feedView
    self.errorView = errorView
    self.loadingView = loadingView
  }
  
  public func didStartLoadingFeed() {
    errorView.display(.noError)
    loadingView.display(FeedLoadingViewModel(isLoading: true))
  }
  
  public func didFinishLoadingFeed(with feed: [FeedImage]) {
    feedView.display(FeedViewModel(feed: feed))
    loadingView.display(FeedLoadingViewModel(isLoading: false))
  }
  
  public func didFinishLoading(with error: Error) {
    errorView.display(.error(message: feedLoadError))
    loadingView.display(FeedLoadingViewModel(isLoading: false))
  }
  
}
