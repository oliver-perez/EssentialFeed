//
//  FeedRefreshViewController.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 06/02/21.
//

import UIKit

final class FeedRefreshViewController: NSObject {
  
  private(set) lazy var view: UIRefreshControl = binded(UIRefreshControl())
  
  private let viewModel: FeedViewModel
  
  init(viewModel: FeedViewModel) {
    self.viewModel = viewModel
  }
    
  @objc func refresh() {
    viewModel.loadFeed()
  }
  
  private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
    viewModel.onLoadingStateChange = { [weak view] isLoading in
      if isLoading {
        view?.beginRefreshing()
      } else {
        view?.endRefreshing()
      }

    }
    view.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return view
  }
  
}
