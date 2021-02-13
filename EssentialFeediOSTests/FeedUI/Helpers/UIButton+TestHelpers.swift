//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Oliver Jordy Pérez Escamilla on 05/02/21.
//

import UIKit

extension UIButton {
  func simulateTap() {
    simulate(event: .touchUpInside)
  }
}
