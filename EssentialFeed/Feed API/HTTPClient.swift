//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Oliver Jordy Pérez Escamilla on 26/10/20.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
  /// The completion handler can be invoked in any thread.
  /// Clients are resposible to dispatch to appropiate threads, if needed.
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
