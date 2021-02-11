//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 06/02/21.
//

import UIKit

protocol FeedRefreshViewControllerDelegate {
  func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject, FeedLoadingView {
  
  @IBOutlet private var view: UIRefreshControl?
  
  var delegate: FeedRefreshViewControllerDelegate?
  
  @IBAction func refresh() {
    delegate?.didRequestFeedRefresh()
  }
  
  func display(_ viewModel: FeedLoadingViewModel) {
    if viewModel.isLoading {
      view?.beginRefreshing()
    } else {
      view?.endRefreshing()
    }
  }
  
}
