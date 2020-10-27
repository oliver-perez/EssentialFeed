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
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
