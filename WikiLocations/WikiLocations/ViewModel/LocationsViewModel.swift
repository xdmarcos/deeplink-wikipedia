//
//  LocationsViewModel.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Common
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

  @discardableResult
  func handleSelectedCell(indexPath: IndexPath) -> Bool {
    guard let location = locationList[safe: indexPath.row],
          let openURL = URL(string: deepLinkString(location))
    else {
      DLog("❌ Error: creating deeplink URL")
      return false
    }

    performOpenURL(url: openURL)
    // handled successfuly
    return true
  }

  func deepLinkString(_ location: Location) -> String {
    String(format: ViewModelConst.deeplinkFormat, location.name, location.lat, location.long)
      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }
}

private extension LocationsViewModel {
  func performOpenURL(url: URL) {
    guard UIApplication.shared.canOpenURL(url) else {
      errorMessage = "locationsViewModel_openurl_error".localized
      DLog(errorMessage ?? "")
      view?.displayError()
      return
    }

    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

  func loadDataDidSuccess(locations: LocationList) {
    title = "\(ViewModelConst.title)(\(locations.count))"
    locationList = locations
    view?.displayNewData()
  }

  func loadDataDidFail(error: Error) {
    errorMessage = error.localizedDescription
    DLog(errorMessage ?? "")
    view?.displayError()
  }
}
