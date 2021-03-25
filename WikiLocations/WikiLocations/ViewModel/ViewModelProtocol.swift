//
//  ViewModelProtocol.swift
//  WikiLocations
//
//  Created by xdmgzdev on 24/03/2021.
//

import Foundation

protocol ViewModelProtocol {
  var view: LocationsViewProtocol? { get set }
  var title: String { get }
  var locationList: LocationList { get }
  var numberOfSections: Int { get }
  var errorMessage: String? { get }
  func loadData()
  func handleSelectedCell(indexPath: IndexPath) -> Bool
}
