//
//  LocationService.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Foundation
import NetworkProvider
import PlistReader

// swiftlint:disable force_try
struct LocationService: NetworkService {
  var baseURL: String {
    let apiNaseURL: String = try! PlistReader.value(for: "API_BASE_URL")
    return "https://\(apiNaseURL)"
  }

  var method: HttpMethod {
    .get
  }

  var httpBody: Encodable? {
    nil
  }

  var headers: [String: String]? {
    nil
  }

  var queryParameters: [URLQueryItem]? {
    nil
  }

  var path: String {
    #if CONF_STAGE
    return "/api/locations"
    #elseif CONF_PROD
    return "/abnamrocoesd/assignment-ios/main/locations.json"
    #endif
  }
}
