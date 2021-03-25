//
//  LocationRepositoryMocks.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

import Foundation
import LightURLSessionDataTask
import NetworkProvider
@testable import WikiLocations

enum LocationRepositoryMocks {
  enum RepositoryError: Swift.Error {
    case networkProviderFailure
  }
  
  static var locationJsonTest: LocationJson {
    LocationJson(locations: [Location(name: "CityNameTest", lat: 12.0090, lon: 8.8765)])
  }

  static var locationListTest: LocationList {
    [Location(name: "CityNameTest", lat: 12.0090, lon: 8.8765)]
  }

  static func clientSucessMock() -> NetworkProviderProtocol {
    #if CONF_STAGE
    let successResult: Result<LocationList, Swift.Error> = .success(locationListTest)
    #elseif CONF_PROD
    let successResult: Result<LocationJson, Swift.Error> = .success(locationJsonTest)
    #endif

    return ClientMock(expectedResult: successResult)
  }

  static func clientFailureMock() -> NetworkProviderProtocol {
    let failureResult: Result<LocationList, Swift.Error> = .failure(RepositoryError.networkProviderFailure)
    return ClientMock(expectedResult: failureResult)
  }
}

struct ClientMock<T: Decodable>: NetworkProviderProtocol {
  let service: NetworkService = ServiceMock()
  var expectedResult: Result<T, Swift.Error>

  func request<T>(
    dataType: T.Type,
    deliverQueue: DispatchQueue,
    completion: @escaping (Result<T, Swift.Error>) -> Void
  ) where T: Decodable {
    completion(Result<T, Swift.Error> {
      switch expectedResult {
      case let .success(value):
        return value as! T
      case .failure:
        throw LocationRepositoryMocks.RepositoryError.networkProviderFailure
      }
    })
  }
}
