//
//  LocationClient.swift
//  WikiLocations
//
//  Created by xdmgzdev on 23/03/2021.
//

import Foundation
import LightURLSessionDataTask
import NetworkProvider

struct LocationClient<Service: NetworkService>: NetworkProviderProtocol {
  let urlSession: SessionProtocol

  init(session: SessionProtocol = Session()) {
    urlSession = session
  }

  func request<T>(
    service: Service,
    dataType: T.Type,
    deliverQueue: DispatchQueue = .main,
    completion: @escaping (Result<T, Swift.Error>) -> Void
  ) where T: Decodable {
    let task = urlSession.dataTask(with: service.urlRequest, dataType: dataType) { result in
      deliverQueue.async {
        completion(result)
      }
    }
    task.resume()
  }
}
