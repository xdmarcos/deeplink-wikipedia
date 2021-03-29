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

    XCTAssertNil(sut.state.errorMessage)
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

    XCTAssertNil(sut.state.errorMessage)
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

    XCTAssertNil(sut.state.errorMessage)
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

    XCTAssertNil(sut.state.errorMessage)
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

    XCTAssertNil(sut.state.errorMessage)
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

    XCTAssertNil(sut.state.errorMessage)
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

    XCTAssertNotNil(sut.state.errorMessage)
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

    XCTAssertNil(sut.state.errorMessage)
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

    XCTAssertNil(sut.state.errorMessage)
    XCTAssertEqual(properlyHandled, expectedResult)
  }
}
