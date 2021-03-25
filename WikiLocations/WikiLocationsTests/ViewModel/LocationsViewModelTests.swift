//
//  LocationsViewModelTests.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

@testable import WikiLocations
import XCTest

class LocationsViewModelTests: XCTestCase {
  // MARK: Subject under test

  var sut: LocationsViewModel?

  // MARK: Test Configuration

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = LocationsViewModel(
      locationsRepository: LocationsViewModelMocks
        .repositorySuccessEmptyMock()
    )
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  // MARK: Tests

  func testGetEmptyLocationListSuccess() throws {
    let mockRepository = LocationsViewModelMocks.repositorySuccessEmptyMock()
    let itemsCount = LocationsViewModelMocks.emptyLocations.count
    sut = LocationsViewModel(locationsRepository: mockRepository)

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    sut.loadData()

    XCTAssertNil(sut.errorMessage)
    XCTAssertEqual(sut.locationList.count, itemsCount)
  }

  func testGetEmptyLocationListSuccessWrongCount() throws {
    let mockRepository = LocationsViewModelMocks.repositorySuccessEmptyMock()
    let itemsCount = 1
    sut = LocationsViewModel(locationsRepository: mockRepository)

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    sut.loadData()

    XCTAssertNil(sut.errorMessage)
    XCTAssertNotEqual(sut.locationList.count, itemsCount)
  }

  func testGetSmallLocationListSuccess() throws {
    let mockRepository = LocationsViewModelMocks.repositorySuccessSmallMock()
    let itemsCount = LocationsViewModelMocks.smallLocations.count
    sut = LocationsViewModel(locationsRepository: mockRepository)

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    sut.loadData()

    XCTAssertNil(sut.errorMessage)
    XCTAssertEqual(sut.locationList.count, itemsCount)
  }

  func testGetSmallLocationListSuccessWrongCount() throws {
    let mockRepository = LocationsViewModelMocks.repositorySuccessSmallMock()
    let itemsCount = LocationsViewModelMocks.bigLocations.count
    sut = LocationsViewModel(locationsRepository: mockRepository)

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    sut.loadData()

    XCTAssertNil(sut.errorMessage)
    XCTAssertNotEqual(sut.locationList.count, itemsCount)
  }

  func testGetBigLocationListSuccess() throws {
    let mockRepository = LocationsViewModelMocks.repositorySuccessBigMock()
    let itemsCount = LocationsViewModelMocks.bigLocations.count
    sut = LocationsViewModel(locationsRepository: mockRepository)

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    sut.loadData()

    XCTAssertNil(sut.errorMessage)
    XCTAssertEqual(sut.locationList.count, itemsCount)
  }

  func testGetBigLocationListSuccessWrongCount() throws {
    let mockRepository = LocationsViewModelMocks.repositorySuccessBigMock()
    let itemsCount = LocationsViewModelMocks.smallLocations.count
    sut = LocationsViewModel(locationsRepository: mockRepository)

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    sut.loadData()

    XCTAssertNil(sut.errorMessage)
    XCTAssertNotEqual(sut.locationList.count, itemsCount)
  }

  func testGetLocationListFailure() throws {
    let mockRepository = LocationsViewModelMocks.repositoryFailureMock()
    let itemsCount = 0
    sut = LocationsViewModel(locationsRepository: mockRepository)

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    sut.loadData()

    XCTAssertNotNil(sut.errorMessage)
    XCTAssertEqual(sut.locationList.count, itemsCount)
  }

  func testHandleSelectedCellEmptyLocationList() throws {
    let indexPath = IndexPath(row: 0, section: 0)
    let expectedResult = false
    sut?.locationList = LocationsViewModelMocks.emptyLocations

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let properlyHandled = sut.handleSelectedCell(indexPath: indexPath)

    XCTAssertNil(sut.errorMessage)
    XCTAssertEqual(properlyHandled, expectedResult)
  }

  func testHandleSelectedCellSmallLocationList_first() throws {
    let indexPath = IndexPath(row: 0, section: 0)
    let expectedResult = true
    sut?.locationList = LocationsViewModelMocks.smallLocations

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let properlyHandled = sut.handleSelectedCell(indexPath: indexPath)

    XCTAssertNil(sut.errorMessage)
    XCTAssertEqual(properlyHandled, expectedResult)
  }

  func testHandleSelectedCellSmallLocationList_last() throws {
    let indexPath = IndexPath(row: 4, section: 0)
    let expectedResult = true
    sut?.locationList = LocationsViewModelMocks.smallLocations

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let properlyHandled = sut.handleSelectedCell(indexPath: indexPath)

    XCTAssertNil(sut.errorMessage)
    XCTAssertEqual(properlyHandled, expectedResult)
  }

  func testHandleSelectedCellSmallLocationList_outOfRange() throws {
    let indexPath = IndexPath(row: 44, section: 0)
    let expectedResult = false
    sut?.locationList = LocationsViewModelMocks.smallLocations

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let properlyHandled = sut.handleSelectedCell(indexPath: indexPath)

    XCTAssertNil(sut.errorMessage)
    XCTAssertEqual(properlyHandled, expectedResult)
  }

  func testCreateDeopLinkString_noSpaces() throws {
    let testLocation = LocationsViewModelMocks.locationNoSpace
    let expectedResult = "wikipedia://places/location?name=CityName&lat=12.009000&lon=8.876500"

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let resultString = sut.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_noSpaces_wrongOrder() throws {
    let testLocation = LocationsViewModelMocks.locationNoSpace
    let expectedResult = "wikipedia://places/location?lat=12.009000&name=CityName&lon=8.876500"

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let resultString = sut.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertNotEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_whiteSpaces_ok() throws {
    let testLocation = LocationsViewModelMocks.locationWhiteSpace
    let expectedResult = "wikipedia://places/location?name=City%20Name&lat=12.009000&lon=8.876500"

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let resultString = sut.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_whiteSpaces_wrong() throws {
    let testLocation = LocationsViewModelMocks.locationWhiteSpace
    let expectedResult = "wikipedia://places/location?name=City Name&lat=12.009000&lon=8.876500"

    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let resultString = sut.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertNotEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_noSpaces_allParams() throws {
    let testLocation = LocationsViewModelMocks.locationNoSpace
    let expectedResultString = "wikipedia://places/location?name=CityName&lat=12.009000&lon=8.876500"
    let numberComponents = 3
    guard let sut = sut else {
      XCTFail("sut object must exist")
      return
    }

    let resultString = sut.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertEqual(resultString, expectedResultString)

    let urlComponents = URLComponents(string: resultString)
    XCTAssertEqual(urlComponents?.queryItems?.count, numberComponents)
    let first = urlComponents?.queryItems?[0].value
    let second = Double(urlComponents?.queryItems?[1].value ?? "")
    let third = Double(urlComponents?.queryItems?[2].value ?? "")
    XCTAssertEqual(first, testLocation.name)
    XCTAssertEqual(second, testLocation.lat)
    XCTAssertEqual(third, testLocation.long)
  }
}
