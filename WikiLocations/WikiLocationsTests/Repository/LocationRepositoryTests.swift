//
//  LocationRepositoryTests.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

@testable import WikiLocations
import XCTest

class LocationRepositoryTests: XCTestCase {
  // MARK: Subject under test

  var sut: LocationRepository = LocationRepository()

  // MARK: Test Configuration

  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  // MARK: Tests

  func testGetLocationListSuccess() throws {
    let mockClient = LocationRepositoryMocks.clientSucessMock()
    let expectedValue = LocationRepositoryMocks.locationListTest
    let dataExpectation = expectation(description: "wait for data")
    var resultValue: LocationList?
    sut = LocationRepository(locationClient: mockClient)

    sut.getLocations { result in
      switch result {
      case let .success(list):
        resultValue = list
      case .failure:
        resultValue = nil
      }
      dataExpectation.fulfill()
    }

    waitForExpectations(timeout: 1.0) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
        return
      }

      XCTAssertEqual(resultValue, expectedValue)
    }
  }

  func testGetLocationListFailure() throws {
    let mockClient = LocationRepositoryMocks.clientFailureMock()
    let expectedValue = LocationRepositoryMocks.RepositoryError.networkProviderFailure
    let dataExpectation = expectation(description: "wait for data")
    var resultValue: LocationRepositoryMocks.RepositoryError?
    sut = LocationRepository(locationClient: mockClient)

    sut.getLocations { result in
      switch result {
      case .success:
        resultValue = nil
      case let .failure(error):
        resultValue = error as? LocationRepositoryMocks.RepositoryError
      }
      dataExpectation.fulfill()
    }

    waitForExpectations(timeout: 1.0) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
        return
      }

      XCTAssertEqual(resultValue, expectedValue)
    }
  }
}
