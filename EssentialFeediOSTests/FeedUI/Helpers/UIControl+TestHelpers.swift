//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Oliver Jordy Pérez Escamilla on 05/02/21.
//

import UIKit

extension UIControl {
  func simulate(event: UIControl.Event) {
    allTargets.forEach { target in
      actions(forTarget: target, forControlEvent: event)?.forEach {
        (target as NSObject).perform(Selector($0))
      }
    }
  }
}
