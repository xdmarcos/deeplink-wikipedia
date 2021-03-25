//
//  LocationRepositoryProtocol.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

protocol LocationRepositoryProtocol {
  func getLocations(completion: @escaping (Result<LocationList, Swift.Error>) -> Void)
}
