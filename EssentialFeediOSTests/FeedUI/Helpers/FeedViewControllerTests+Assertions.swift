//
//  FeedViewControllerTests+Assertions.swift
//  EssentialFeediOSTests
//
//  Created by Oliver Jordy Pérez Escamilla on 05/02/21.
//

import XCTest
import EssentialFeed
import EssentialFeediOS

extension FeedUIIntegrationTests {
  
  func assertThat(_ sut: FeedViewController, hasViewConfiguredFor image: FeedImage, at index: Int, file: StaticString = #filePath, line: UInt = #line) {
    let view = sut.feedImageView(at: index)
    
    guard let cell = view as? FeedImageCell else {
      return XCTFail("Expected \(FeedImageCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
    }
    
    let shouldLocationBeVisible = (image.location != nil)
    XCTAssertEqual(cell.isShowingLocation, shouldLocationBeVisible, "Expected `isShowingLocation` to be \(shouldLocationBeVisible) for the image view at index (\(index))")
    
    XCTAssertEqual(cell.locationText, image.location, "Expected location text to be \(String(describing: image.location)) for image view at index (\(index)", file: file, line: line)
    
    XCTAssertEqual(cell.descriptionText, image.description, "Expected description text to be \(String(describing: image.description)) for image view at index (\(index)", file: file, line: line)
    
  }

}

