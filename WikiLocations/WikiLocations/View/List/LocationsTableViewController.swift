//
//  LocationsTableViewController.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import CommonUI
import UIKit

class LocationsTableViewController: UIViewController {
  let sceneView = CommonUI.genericTableView
  var viewModel: ViewModelProtocol

  // MARK: Object lifecycle

  public init(viewModel: ViewModelProtocol = LocationsViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    setup()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup() {
    viewModel.view = self
  }

  // MARK: View lifecycle

  override func loadView() {
    view = sceneView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = viewModel.title
    sceneView.tableView.delegate = self
    sceneView.tableView.dataSource = self
    sceneView.tableView.register(
      BaseTableViewCell.self,
      forCellReuseIdentifier: BaseTableViewCell.reuseIdentifier
    )

    viewModel.loadData()
  }
}

// MARK: UITableView delegate & datasource

extension LocationsTableViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in _: UITableView) -> Int {
    return viewModel.numberOfSections
  }

  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    return viewModel.locationList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(
      withIdentifier: BaseTableViewCell.reuseIdentifier,
      for: indexPath
    ) as? BaseTableViewCell {
      return configureCell(cell, forIndexPath: indexPath) ?? UITableViewCell()
    }

    return UITableViewCell()
  }

  func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard viewModel.locationList[safe: indexPath.row] != nil else { return }
    viewModel.handleSelectedCell(indexPath: indexPath)
  }

  private func configureCell(
    _ cell: BaseTableViewCell,
    forIndexPath indexPath: IndexPath
  ) -> UITableViewCell? {
    guard let location = viewModel.locationList[safe: indexPath.row] else { return nil }

    cell.symbolLabel.text = String(location.name.uppercased().first ?? "U")
    cell.titleLabel.text = location.name
    cell.detailLabel.text = "Lat: \(location.lat), Lon: \(location.long)"

    return cell
  }
}

extension LocationsTableViewController: LocationsViewProtocol {
  func displayNewData() {
    title = viewModel.title
    sceneView.tableView.reloadData()
  }

  func displayError() {
    let alert = UIAlertController(
      title: NSLocalizedString("locationsTableVC_alert_error", comment: "Alert error title"),
      message: viewModel.errorMessage,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(
      title: NSLocalizedString("locationsTableVC_alert_ok", comment: "Alert ok button"),
      style: .default,
      handler: nil
    ))
    present(alert, animated: true, completion: nil)
  }
}
