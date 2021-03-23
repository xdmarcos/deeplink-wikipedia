//
//  LocationsTableViewController.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import UIKit

class LocationsTableViewController: UIViewController {
  let viewModel: ViewModelProtocol = LocationsViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    title = NSLocalizedString("locationsTableVC_title", comment: "Title for navigationBar")

    viewModel.loadData()
  }
}
