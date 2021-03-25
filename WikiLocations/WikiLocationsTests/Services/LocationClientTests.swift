//
//  LocationClientTests.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

@testable import WikiLocations
import XCTest

class LocationClientTests: XCTestCase {
  // MARK: Subject under test

  var sut: LocationClient = LocationClient()

  // MARK: Test Configuration

  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  // MARK: Tests

  func testGetLocationListSuccess() throws {
    let mockSession = LocationClientMocks.sessionSucessMock()
    let mockService = LocationClientMocks.serviceMock
    let expectedValue = LocationClientMocks.locationTest
    let dataExpectation = expectation(description: "wait for data")
    var resultValue: Location?
    sut = LocationClient(session: mockSession, service: mockService)

    sut.request(dataType: Location.self, completion: { result in
      switch result{
      case let .success(location):
        resultValue = location
      case .failure(_):
        resultValue = nil
      }
      dataExpectation.fulfill()
    })

    waitForExpectations(timeout: 1.0) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
        return
      }

      XCTAssertEqual(resultValue, expectedValue)
    }
  }

  func testGetLocationListFailure() throws {
    let mockSession = LocationClientMocks.sessionFailureMock()
    let mockService = LocationClientMocks.serviceMock
    let expectedValue = LocationClientMocks.ClientError.sessionDataTaskError
    let dataExpectation = expectation(description: "wait for data")
    var resultValue: LocationClientMocks.ClientError?
    sut = LocationClient(session: mockSession, service: mockService)

    sut.request(dataType: Location.self, completion: { result in
      switch result{
      case .success(_):
        resultValue = nil
      case let .failure(error):
        resultValue = error as? LocationClientMocks.ClientError
      }
      dataExpectation.fulfill()
    })

    waitForExpectations(timeout: 1.0) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
        return
      }

      XCTAssertEqual(resultValue, expectedValue)
    }
  }
}
