//
//  LocationRepository.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import NetworkProvider

struct LocationRepository: LocationRepositoryProtocol {
  let client: NetworkProviderProtocol

  init(locationClient: NetworkProviderProtocol = LocationClient()) {
    client = locationClient
  }

  func getLocations(completion: @escaping (Result<LocationList, Swift.Error>) -> Void) {
    #if CONF_STAGE
    client.request(dataType: LocationList.self, deliverQueue: .main, completion: completion)
    #elseif CONF_PROD
    client.request(dataType: LocationJson.self, deliverQueue: .main) { result in
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
