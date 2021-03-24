//
//  Location.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Foundation

typealias LocationList = [Location]

struct Location: Decodable, Hashable, Equatable {
  let name: String
  let lat, long: Double

  enum CodingKeys: String, CodingKey {
    case name
    case lat
    case long
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let defaultName = NSLocalizedString("location_default_name", comment: "Default name")
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? defaultName
    lat = Self.ensureDoubleValue(container, forKey: .lat)
    long = Self.ensureDoubleValue(container, forKey: .long)
  }
}

private extension Location {
  static func ensureDoubleValue(
    _ container: KeyedDecodingContainer<CodingKeys>,
    forKey key: CodingKeys
  ) -> Double {
    var doubleValue: Double?

    do {
      doubleValue = try container.decode(Double.self, forKey: key)
    } catch {
      guard let stringValue = try? container.decode(String.self, forKey: key) else {
        return 0.0
      }
      doubleValue = Double(stringValue)
    }
    
    return doubleValue ?? 0.0
  }
}
