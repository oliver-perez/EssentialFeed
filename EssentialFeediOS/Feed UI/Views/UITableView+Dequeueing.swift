//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Oliver Jordy Pérez Escamilla on 11/02/21.
//

import UIKit

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>() -> T {
    let identifier = String(describing: T.self)
    return dequeueReusableCell(withIdentifier: identifier) as! T
  }
}
