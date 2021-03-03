//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 26/10/20.
//

import Foundation

public protocol HTTPClientTask {
  func cancel()
}

public protocol HTTPClient {
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
  
  /// The completion handler can be invoked in any thread.
  /// Clients are resposible to dispatch to appropiate threads, if needed.
  @discardableResult
    func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask}
