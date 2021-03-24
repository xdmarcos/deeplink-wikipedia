//
//  LocationsViewModel.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import UIKit

class LocationsViewModel: ViewModelProtocol {
  private enum ViewModelConst {
    static let title = "locationsTableVC_title".localized
    static let deeplinkFormat = "wikipedia://places/location?name=%@&lat=%f&lon=%f"
  }

  var view: LocationsViewProtocol?
  var title = ViewModelConst.title
  var errorMessage: String?
  var numberOfSections = 1
  var locationList: LocationList = []
  let locationsRepo: LocationRepositoryProtocol

  init(locationsRepository: LocationRepositoryProtocol = LocationRepository()) {
    locationsRepo = locationsRepository
  }

  func loadData() {
    locationsRepo.getLocations { [weak self] result in
      guard let self = self else { return }

      switch result {
      case let .success(locations):
        self.loadDataDidSuccess(locations: locations)
      case let .failure(error):
        self.loadDataDidFail(error: error)
      }
    }
  }

  func handleSelectedCell(indexPath: IndexPath) {
    guard let location = locationList[safe: indexPath.row],
          let deeplinkString = String(
            format: ViewModelConst.deeplinkFormat,
            location.name,
            location.lat,
            location.long
          )
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let openURL = URL(string: deeplinkString) else { return }

    guard UIApplication.shared.canOpenURL(openURL) else {
      errorMessage = "locationsViewModel_openurl_error".localized
      view?.displayError()
      return
    }

    UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
  }
}

private extension LocationsViewModel {
  func loadDataDidSuccess(locations: LocationList) {
    title = "\(ViewModelConst.title)(\(locations.count))"
    locationList = locations
    view?.displayNewData()
  }

  func loadDataDidFail(error: Error) {
    errorMessage = error.localizedDescription
    view?.displayError()
  }
}
