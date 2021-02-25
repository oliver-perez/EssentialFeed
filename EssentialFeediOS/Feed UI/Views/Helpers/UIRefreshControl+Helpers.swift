//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 24/02/21.
//

import UIKit

extension UIRefreshControl {
  func update(isRefreshing: Bool) {
    isRefreshing ? beginRefreshing() : endRefreshing()
  }
}
