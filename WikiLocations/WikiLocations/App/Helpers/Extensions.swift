//
//  Extensions.swift
//  WikiLocations
//
//  Created by xdmgzdev on 24/03/2021.
//

import Foundation

public extension Collection {
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

public extension String {
  /// Fetches a localised String Arguments
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }

  /// Fetches a localised String Arguments
  ///
  /// - Parameter arguments: parameters to be added in a string
  /// - Returns: localized string
  func localized(with arguments: [CVarArg]) -> String {
    return String(format: localized, locale: Locale.current, arguments: arguments)
  }
}
