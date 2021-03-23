//
//  RootViewController.swift
//  WikiLocations
//
//  Created by xdmgzdev on 22/03/2021.
//

import UIKit

class RootViewController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()

    viewControllers = [UIViewController()]
    view.backgroundColor = .systemBackground
  }
}
