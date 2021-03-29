//
//  LocationsViewModel.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Common
import UIKit

class LocationsViewModel: ViewModelProtocol {
  private var locationList: LocationList = []

  weak var output: LocationsViewProtocol?
  var state: ViewState = ViewState()
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
          let openURL = URL(string: Converter.deepLinkString(location))
    else {
      DLog("❌ Error: creating deeplink URL")
      return false
    }

    performOpenURL(url: openURL)
    // handled successfuly
    return true
  }
}

private extension LocationsViewModel {
  func performOpenURL(url: URL) {
    guard UIApplication.shared.canOpenURL(url) else {
      let errorMessage = "locationsViewModel_openurl_error".localized
      state.errorMessage = errorMessage
      DLog(errorMessage)

      output?.displayError()
      return
    }

    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

  func loadDataDidSuccess(locations: LocationList) {
    locationList = locations

    let title = Converter.convert(locationsNumber: locationList.count)
    let locationsInfo = Converter.convert(locations: locationList)
    state.titleNavBar = title
    state.locations = locationsInfo

    output?.displayNewData()
  }

  func loadDataDidFail(error: Error) {
    let errorMessage = error.localizedDescription
    state.errorMessage = errorMessage
    DLog(errorMessage)

    output?.displayError()
  }
}
