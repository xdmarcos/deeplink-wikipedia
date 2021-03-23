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
    #if CONF_STAGE
    view.backgroundColor = UIColor(named: "AccentColor")
    #elseif CONF_PROD
    view.backgroundColor = .systemBackground
    #endif

  }
}
