//
//  LocationClientMocks.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

@testable import WikiLocations
import Foundation
import LightURLSessionDataTask
import NetworkProvider

enum LocationClientMocks {
  enum ClientError: Swift.Error {
    case sessionDataTaskError
  }

  static var locationTest: Location {
    Location(name: "CityName", lat: 12.0090, lon: 8.8765)
  }

  static func sessionSucessMock() -> SessionProtocol {
    let successResult: Result<Location, Swift.Error> = .success(locationTest)
    return SessionMock(expectedResult: successResult)
  }

  static func sessionFailureMock() -> SessionProtocol {
    let failureResult: Result<Location, Swift.Error> = .failure(ClientError.sessionDataTaskError)
    return SessionMock(expectedResult: failureResult)
  }

  static var serviceMock: NetworkService {
    ServiceMock()
  }
}

struct ServiceMock: NetworkService {
  var baseURL: String {
    return "https://google.es"
  }

  var method: HttpMethod {
    .get
  }

  var httpBody: Encodable? {
    nil
  }

  var headers: [String: String]? {
    nil
  }

  var queryParameters: [URLQueryItem]? {
    nil
  }

  var path: String {
    "/path"
  }
}

struct SessionMock<T: Decodable>: SessionProtocol {
  var expectedResult: Result<T, Swift.Error>

  func dataTask<T: Decodable>(
    with request: URLRequest,
    dataType: T.Type,
    completionHandler: @escaping (Result<T, Swift.Error>) -> Void
  ) -> URLSessionDataTask {
    dataTask(
      with: request,
      dataType: dataType,
      requestOptions: RequestOptions(),
      responseOptions: ResponseOptions(),
      completionHandler: completionHandler
    )
  }

  func dataTask<T: Decodable>(
    with request: URLRequest,
    dataType: T.Type,
    requestOptions: RequestOptionsProtocol,
    responseOptions: ResponseOptionsProtocol,
    completionHandler: @escaping (Result<T, Swift.Error>) -> Void
  ) -> URLSessionDataTask {
    return URLSession.shared.dataTask(with: request) { (_, _, _) in
      completionHandler(Result<T, Swift.Error> {
        switch expectedResult {
        case let .success(value):
          return value as! T
        case .failure:
          throw LocationClientMocks.ClientError.sessionDataTaskError
        }
      })
    }
  }
}
