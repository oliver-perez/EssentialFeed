//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Oliver Jordy Pérez Escamilla on 04/12/20.
//

import Foundation
import XCTest

extension XCTestCase {
  func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
    addTeardownBlock { [weak instance] in
      XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
    }
  }
}
