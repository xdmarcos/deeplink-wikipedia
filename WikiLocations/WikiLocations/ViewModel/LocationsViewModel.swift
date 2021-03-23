//
//  LocationsViewModel.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Foundation

protocol ViewModelProtocol {
  func loadData()
}

struct LocationsViewModel: ViewModelProtocol {
  let locationsRepo: LocationRepositoryProtocol

  init(locationsRepository: LocationRepositoryProtocol = LocationRepository()) {
    self.locationsRepo = locationsRepository
  }

  func loadData() {
    locationsRepo.getLocations { result in
      switch result{
      case let .success(locations):
        print("Locations: \(locations)")
      case let .failure(error):
        print("Error: \(error)")
      }
    }
  }
}
