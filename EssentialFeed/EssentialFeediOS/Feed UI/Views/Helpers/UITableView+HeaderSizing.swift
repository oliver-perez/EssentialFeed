//
//  UITableView+HeaderSizing.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 11/03/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import UIKit

extension UITableView {
  func sizeTableHeaderToFit() {
    guard let header = tableHeaderView else { return }

    let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

    let needsFrameUpdate = header.frame.height != size.height
    if needsFrameUpdate {
      header.frame.size.height = size.height
      tableHeaderView = header
    }
  }
}
