//
//  Location.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Foundation

typealias LocationList = [Location]

struct Location: Decodable, Equatable {
  let name: String?
  let lat, long: Double

  enum CodingKeys: String, CodingKey {
    case name
    case lat
    case long
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let defaultName = NSLocalizedString("location_default_name",comment: "Default name")
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? defaultName

    var latDouble: Double?
    do {
      latDouble = try container.decode(Double.self, forKey: .lat)
    } catch {
      let latString = try container.decode(String.self, forKey: .lat)
      latDouble = Double(latString)
    }
    lat = latDouble ?? 0.0

    var lonDouble: Double?
    do {
      lonDouble = try container.decode(Double.self, forKey: .long)
    } catch {
      let lonString = try container.decode(String.self, forKey: .long)
      lonDouble = Double(lonString)
    }
    long = lonDouble ?? 0.0
  }
}
