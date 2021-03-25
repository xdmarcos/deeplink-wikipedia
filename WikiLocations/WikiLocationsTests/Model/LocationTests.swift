//
//  LocationTests.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

@testable import WikiLocations
import XCTest

class LocationTests: XCTestCase {
  // MARK: Test Configuration

  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func testLocationCreation() {
    let name = LocationsMocks.name
    let latitude = LocationsMocks.latitude
    let longitude = LocationsMocks.longitude

    let location = Location(name: name, lat: latitude, lon: longitude)

    XCTAssertEqual(name, location.name)
    XCTAssertEqual(latitude, location.lat)
    XCTAssertEqual(longitude, location.long)
  }

  func testLocationCreationTypes() {
    let name = LocationsMocks.name
    let latitude = LocationsMocks.latitude
    let longitude = LocationsMocks.longitude

    let location = Location(name: name, lat: latitude, lon: longitude)

    XCTAssertEqual(String(describing: String.self), String(describing: type(of: location.name)))
    XCTAssertEqual(String(describing: Double.self), String(describing: type(of: location.lat)))
    XCTAssertEqual(String(describing: Double.self), String(describing: type(of: location.long)))
  }

  func testLocationCreationNumberJson() {
    let name = LocationsMocks.name
    let latitude = LocationsMocks.latitude
    let longitude = LocationsMocks.longitude
    let data = LocationsMocks.numberJson.data(using: .utf8)!

    let location = try? JSONDecoder().decode(Location.self, from: data)

    XCTAssertNotNil(location)
    XCTAssertEqual(name, location?.name)
    XCTAssertEqual(latitude, location?.lat)
    XCTAssertEqual(longitude, location?.long)
  }

  func testLocationCreationStringJson() {
    let name = LocationsMocks.name
    let latitude = LocationsMocks.latitude
    let longitude = LocationsMocks.longitude
    let data = LocationsMocks.stringJson.data(using: .utf8)!

    let location = try? JSONDecoder().decode(Location.self, from: data)

    XCTAssertNotNil(location)
    XCTAssertEqual(name, location?.name)
    XCTAssertEqual(latitude, location?.lat)
    XCTAssertEqual(longitude, location?.long)
  }

  func testLocationCreationTypesNumberJson() {
    let data = LocationsMocks.numberJson.data(using: .utf8)!

    guard let location = try? JSONDecoder().decode(Location.self, from: data) else {
      XCTFail("Location object must exist")
      return
    }

    XCTAssertEqual(String(describing: String.self), String(describing: type(of: location.name)))
    XCTAssertEqual(String(describing: Double.self), String(describing: type(of: location.lat)))
    XCTAssertEqual(String(describing: Double.self), String(describing: type(of: location.long)))
  }

  func testLocationCreationTypesStringJson() {
    let data = LocationsMocks.stringJson.data(using: .utf8)!

    guard let location = try? JSONDecoder().decode(Location.self, from: data) else {
      XCTFail("Location object must exist")
      return
    }

    XCTAssertEqual(String(describing: String.self), String(describing: type(of: location.name)))
    XCTAssertEqual(String(describing: Double.self), String(describing: type(of: location.lat)))
    XCTAssertEqual(String(describing: Double.self), String(describing: type(of: location.long)))
  }
}
