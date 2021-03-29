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
    viewModel.output = self
  }

  // MARK: View lifecycle

  override func loadView() {
    view = sceneView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh".localized)
    refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
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

  @objc func refresh(_: AnyObject) {
    retrieveLocations()
  }
}

// MARK: LocationsViewProtocol

extension LocationsTableViewController: LocationsViewProtocol {
  func displayNewData() {
    guard let state = viewModel.state as? ViewState else { return }
    title = state.titleNavBar
    refreshControl.endRefreshing()
    update(with: state.locations)
  }

  func displayError() {
    guard let state = viewModel.state as? ViewState else { return }
    let alert = UIAlertController(
      title: "locationsTableVC_alert_error".localized,
      message: state.errorMessage,
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
    guard let viewModel = viewModel as? LocationsViewModel else { return }
    viewModel.handleSelectedCell(indexPath: indexPath)
  }
}

// MARK: UITableView diffable datasource
extension LocationsTableViewController {
  func update(with list: [LocationInfo], animate: Bool = true) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, LocationInfo>()
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

  // swiftlint:disable force_cast
  func makeDataSource() -> UITableViewDiffableDataSource<Section, LocationInfo> {
    let reuseIdentifier = BaseTableViewCell.reuseIdentifier

    return UITableViewDiffableDataSource(
      tableView: sceneView.tableView,
      cellProvider: { tableView, indexPath, location in
        let cell = tableView.dequeueReusableCell(
          withIdentifier: reuseIdentifier,
          for: indexPath
        ) as! BaseTableViewCell

        cell.symbolLabel.text = location.symbol
        cell.titleLabel.text = location.title
        cell.detailLabel.text = location.detail
        return cell
      }
    )
  }
}
