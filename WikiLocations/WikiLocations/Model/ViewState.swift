//
//  ViewState.swift
//  WikiLocations
//
//  Created by xdmgzdev on 29/03/2021.
//

import Foundation

struct ViewState: ViewRepresentable {
  var titleNavBar: String
  var locations: [LocationInfo]
  var errorMessage: String?

  init(titleNavBar: String = "", locations: [LocationInfo] = [], errorMessage: String? = nil) {
    self.titleNavBar = titleNavBar
    self.locations = locations
    self.errorMessage = errorMessage
  }
}

struct LocationInfo: Hashable {
  let symbol: String
  let title: String
  let detail: String
}

enum Section: CaseIterable {
  case locations
}
