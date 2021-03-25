//
//  LocationMocks.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

import Foundation

enum LocationsMocks {
  static let name = "City"
  static let latitude = 12.9876
  static let longitude = -8.9843
  static let latitudeString = "12.9876"
  static let longitudeString = "-8.9843"

  static let stringJson = """
  {
    "name": "City",
    "lat": "12.9876",
    "long": "-8.9843"
  }
  """



  static let numberJson = """
  {
    "name": "City",
    "lat": 12.9876,
    "long": -8.9843
  }
  """
}
