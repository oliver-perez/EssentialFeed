//
//  FeedViewController.swift
//  Prototype
//
//  Created by Oliver Jordy Pérez Escamilla on 30/01/21.
//

import UIKit

struct FeedImageViewModel {
  let description: String?
  let location: String?
  let imageName: String
}

class FeedViewController: UITableViewController {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    tableView.dequeueReusableCell(withIdentifier: "FeedImageCell")!
  }
  
}
