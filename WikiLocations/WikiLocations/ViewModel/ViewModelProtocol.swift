//
//  ViewModelProtocol.swift
//  WikiLocations
//
//  Created by xdmgzdev on 24/03/2021.
//

import Foundation

protocol ViewModelProtocol {
  var output: LocationsViewProtocol? { get set }
  var state: ViewState { get }
  func loadData()
  func handleSelectedCell(indexPath: IndexPath) -> Bool
}
