//
//  Converter.swift
//  WikiLocations
//
//  Created by xdmgzdev on 29/03/2021.
//

import Foundation

struct Converter {
  private enum ViewModelConst {
    static let title = "locationsTableVC_title".localized
    static let deeplinkFormat = "wikipedia://places/location?name=%@&lat=%f&lon=%f"
  }

  static func convert(locations: LocationList) -> [LocationInfo] {
    let locationsInfo: [LocationInfo] = locations.map { location in
      let symbolLabel = String(location.name.uppercased().first ?? "U")
      let titleLabel = location.name
      let detailLabel = "Lat: \(location.lat), Lon: \(location.long)"
      return LocationInfo(symbol: symbolLabel, title: titleLabel, detail: detailLabel)
    }

    return locationsInfo
  }

  static func convert(locationsNumber: Int) -> String {
    "\(ViewModelConst.title)(\(locationsNumber))"
  }

  static func deepLinkString(_ location: Location) -> String {
    String(format: ViewModelConst.deeplinkFormat, location.name, location.lat, location.long)
      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
  }
}
