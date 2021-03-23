//
//  LocationRepository.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Foundation
import NetworkProvider

struct LocationRepository: LocationRepositoryProtocol {
  let locationClient: LocationClient<LocationService>

  init(locationClient: LocationClient<LocationService> = LocationClient<LocationService>()) {
    self.locationClient = locationClient
  }

  func getLocations(completion: @escaping (Result<LocationList, Swift.Error>) -> Void) {
    #if CONF_STAGE
    locationClient.request(
      service: LocationService(),
      dataType: LocationList.self,
      completion: completion
    )
    #elseif CONF_PROD
    locationClient.request(service: LocationService(), dataType: LocationJson.self) { result in
      switch result {
      case let .success(locationJson):
        completion(.success(locationJson.locations))
      case let .failure(error):
        completion(.failure(error))
      }
    }
    #endif
  }
}
