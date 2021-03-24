//
//  LocationJson.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

struct LocationJson: Decodable, Hashable, Equatable {
  let locations: [Location]
}
