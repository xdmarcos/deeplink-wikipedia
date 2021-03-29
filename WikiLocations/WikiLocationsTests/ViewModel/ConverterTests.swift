//
//  ConverterTests.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 29/03/2021.
//

@testable import WikiLocations
import XCTest

class ConverterTests: XCTestCase {
  func testCreateDeopLinkString_noSpaces() throws {
    let testLocation = LocationsViewModelMocks.locationNoSpace
    let expectedResult = "wikipedia://places/location?name=CityName&lat=12.009000&lon=8.876500"

    let resultString = Converter.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_noSpaces_wrongOrder() throws {
    let testLocation = LocationsViewModelMocks.locationNoSpace
    let expectedResult = "wikipedia://places/location?lat=12.009000&name=CityName&lon=8.876500"

    let resultString = Converter.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertNotEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_whiteSpaces_ok() throws {
    let testLocation = LocationsViewModelMocks.locationWhiteSpace
    let expectedResult = "wikipedia://places/location?name=City%20Name&lat=12.009000&lon=8.876500"

    let resultString = Converter.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_whiteSpaces_wrong() throws {
    let testLocation = LocationsViewModelMocks.locationWhiteSpace
    let expectedResult = "wikipedia://places/location?name=City Name&lat=12.009000&lon=8.876500"

    let resultString = Converter.deepLinkString(testLocation)

    XCTAssertTrue(resultString.count > 0)
    XCTAssertNotEqual(resultString, expectedResult)
  }

  func testCreateDeopLinkString_noSpaces_allParams() throws {
    let testLocation = LocationsViewModelMocks.locationNoSpace
    let expectedResultString = "wikipedia://places/location?name=CityName&lat=12.009000&lon=8.876500"
    let numberComponents = 3

    let resultString = Converter.deepLinkString(testLocation)

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
