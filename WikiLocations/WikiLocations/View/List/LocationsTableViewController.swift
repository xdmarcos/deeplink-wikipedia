//
//  LocationsTableViewController.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import CommonUI
import UIKit

class LocationsTableViewController: UIViewController {
  private let sceneView = CommonUI.genericTableView
  private var viewModel: ViewModelProtocol
  private var refreshControl = UIRefreshControl()
  private lazy var dataSource = makeDataSource()

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

    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    sceneView.tableView.addSubview(refreshControl)

    sceneView.tableView.delegate = self
    sceneView.tableView.dataSource = dataSource
    sceneView.tableView.register(
      BaseTableViewCell.self,
      forCellReuseIdentifier: BaseTableViewCell.reuseIdentifier
    )
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    retrieveLocations()
  }

  @objc func refresh(_ sender: AnyObject) {
    retrieveLocations()
  }
}

// MARK: LocationsViewProtocol

extension LocationsTableViewController: LocationsViewProtocol {
  func displayNewData() {
    title = viewModel.title
    refreshControl.endRefreshing()
    update(with: viewModel.locationList)
  }

  func displayError() {
    let alert = UIAlertController(
      title: "locationsTableVC_alert_error".localized,
      message: viewModel.errorMessage,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(
      title: "locationsTableVC_alert_ok".localized,
      style: .default,
      handler: nil
    ))
    present(alert, animated: true, completion: nil)
  }
}

// MARK: UITableView delegate

extension LocationsTableViewController: UITableViewDelegate {
  func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard viewModel.locationList[safe: indexPath.row] != nil else { return }
    viewModel.handleSelectedCell(indexPath: indexPath)
  }
}

// MARK: UITableView diffable datasource

extension LocationsTableViewController {
  enum Section: CaseIterable {
    case locations
  }
}

extension LocationsTableViewController {
  func update(with list: LocationList, animate: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(list, toSection: .locations)

    dataSource.apply(snapshot, animatingDifferences: animate)
  }
}

// MARK: Private

private extension LocationsTableViewController {
  func retrieveLocations() {
    viewModel.loadData()
  }

  func makeDataSource() -> UITableViewDiffableDataSource<Section, Location> {
    let reuseIdentifier = BaseTableViewCell.reuseIdentifier

    return UITableViewDiffableDataSource(
      tableView: sceneView.tableView,
      cellProvider: { tableView, indexPath, location in
        let cell = tableView.dequeueReusableCell(
          withIdentifier: reuseIdentifier,
          for: indexPath
        ) as! BaseTableViewCell

        cell.symbolLabel.text = String(location.name.uppercased().first ?? "U")
        cell.titleLabel.text = location.name
        cell.detailLabel.text = "Lat: \(location.lat), Lon: \(location.long)"
        return cell
      }
    )
  }
}
