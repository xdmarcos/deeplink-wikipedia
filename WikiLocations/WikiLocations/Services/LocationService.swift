//
//  LocationService.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Foundation
import NetworkProvider
import PlistReader

struct LocationService: NetworkService {
  var baseURL: String {
    let apiNaseURL: String = try! PlistInfo.value(for: "API_BASE_URL")
    return "https://\(apiNaseURL)"
  }

  var method: HttpMethod {
    return .get
  }

  var httpBody: Encodable? {
    return nil
  }

  var headers: [String: String]? {
    return nil
  }
  
  var queryParameters: [URLQueryItem]? {
    return nil
  }

  var path: String {
    #if CONF_STAGE
    return "/api/locations"
    #elseif CONF_PROD
    return "/abnamrocoesd/assignment-ios/main/locations.json"
    #endif
  }
}
