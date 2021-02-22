//
//  FeedPresenterTests.swift
//  EssentialFeedTests
//
//  Created by Oliver Jordy Pérez Escamilla on 21/02/21.
//

import XCTest

final class FeedPresenter {
  init(view: Any) {
    
  }
}

class FeedPresenterTests: XCTestCase {
  
  func test_init_doesNotSendMessagesToView() {
    let view = ViewSpy()
    
    _ = FeedPresenter(view: view)
    
    XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
  }
  
  // MARK: - Helpers
  
  private class ViewSpy {
    let messages = [Any]()
  }
  
}


