//
//  SceneDelegate.swift
//  EssentialApp
//
//  Created by Oliver Jordy Pérez Escamilla on 06/03/21.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
  
    let url = URL(string: "https://essentialdeveloper.com/feed-case-study/test-api/feed")!
    let session = URLSession(configuration: .ephemeral)
    let client = URLSessionHTTPClient(session: session)
    let feedLoader = RemoteFeedLoader(url: url, client: client)
    let imageLoader = RemoteFeedImageDataLoader(client: client)
    
    let feedViewController = FeedUIComposer.feedComposedWith(
      feedLoader: feedLoader,
      imageLoader: imageLoader)
    
    window?.rootViewController = feedViewController
  }

}

