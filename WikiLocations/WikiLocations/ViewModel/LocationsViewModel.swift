//
//  LocationsViewModel.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Combine
import UIKit

class LocationsViewModel: ViewModelProtocol {
  private enum ViewModelConst {
    static let title = "locationsTableVC_title".localized
    static let deeplinkFormat = "wikipedia://places/location?name=%@&lat=%f&lon=%f"
  }
  private let locationsRepo: LocationRepositoryProtocol

  @Published var title = ViewModelConst.title
  @Published var errorMessage: String?
  @Published var locationList: LocationList = []
  @Published var isLoading: Bool = false

  init(locationsRepository: LocationRepositoryProtocol = LocationRepository()) {
    locationsRepo = locationsRepository
  }

  func loadData() {
    isLoading = true
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
      return
    }

    UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
  }
}

private extension LocationsViewModel {
  func loadDataDidSuccess(locations: LocationList) {
    isLoading = false
    title = "\(ViewModelConst.title)(\(locations.count))"
    locationList = locations
  }

  func loadDataDidFail(error: Error) {
    isLoading = false
    errorMessage = error.localizedDescription
  }
}
