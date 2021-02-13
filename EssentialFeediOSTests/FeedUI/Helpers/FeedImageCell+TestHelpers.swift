//
//  FeedImageCell+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Oliver Jordy Pérez Escamilla on 05/02/21.
//

import UIKit
import EssentialFeediOS
 
extension FeedImageCell {
  
  func simulateRetryAction() {
    feedImageRetryButton.simulateTap()
  }
  
  var isShowingLocation: Bool {
    !locationContainer.isHidden
  }
  
  var isShowingImageLoadingIndicator: Bool {
    feedImageContainer.isShimmering
  }
  
  var locationText: String? {
    locationLabel.text
  }
  
  var descriptionText: String? {
    descriptionLabel.text
  }
  
  var renderedImage: Data? {
    feedImageView.image?.pngData()
  }
  
  var isShowingRetryAction: Bool {
    return !feedImageRetryButton.isHidden
  }
  
}
