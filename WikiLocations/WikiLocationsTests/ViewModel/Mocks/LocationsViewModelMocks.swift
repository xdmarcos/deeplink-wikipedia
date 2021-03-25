//
//  LocationsViewModelMocks.swift
//  WikiLocationsTests
//
//  Created by xdmgzdev on 25/03/2021.
//

@testable import WikiLocations
import Foundation

typealias RepositoryResult = Result<LocationList, Swift.Error>
enum LocationsViewModelMocks {
  enum RepositoryError: Swift.Error {
    case locationsNotFound
  }

  static var locationNoSpace: Location {
    Location(name: "CityName", lat: 12.0090, lon: 8.8765)
  }

  static var locationWhiteSpace: Location {
    Location(name: "City Name", lat: 12.0090, lon: 8.8765)
  }

  static var emptyLocations: LocationList {
    []
  }

  static var smallLocations: LocationList {
    smallJsonList
  }

  static var bigLocations: LocationList {
    bigJsonList
  }

  static func repositorySuccessEmptyMock() -> LocationRepositoryProtocol {
    let result: RepositoryResult = .success(emptyLocations)
    let repo = LocationsRepositoryMock(expectedResult: result)
    return repo
  }

  static func repositorySuccessSmallMock() -> LocationRepositoryProtocol {
    let result: RepositoryResult = .success(smallLocations)
    let repo = LocationsRepositoryMock(expectedResult: result)
    return repo
  }

  static func repositorySuccessBigMock() -> LocationRepositoryProtocol {
    let result: RepositoryResult = .success(bigLocations)
    let repo = LocationsRepositoryMock(expectedResult: result)
    return repo
  }

  static func repositoryFailureMock() -> LocationRepositoryProtocol {
    let result: RepositoryResult = .failure(RepositoryError.locationsNotFound)
    let repo = LocationsRepositoryMock(expectedResult: result)
    return repo
  }
}

struct LocationsRepositoryMock: LocationRepositoryProtocol {
  var expectedResult: RepositoryResult
  func getLocations(completion: @escaping (RepositoryResult) -> Void) {
    completion(expectedResult)
  }
}

private extension LocationsViewModelMocks {
  static var smallJsonList: LocationList {
    let data = smallJson.data(using: .utf8)!
    return try! JSONDecoder().decode(LocationList.self, from: data)
  }
  
  static var bigJsonList: LocationList {
    let data = bigJson.data(using: .utf8)!
    do {
      return try JSONDecoder().decode(LocationList.self, from: data)
    } catch {
      if let derror = error as? DecodingError {
        print("\(derror)")
      }
      fatalError()
    }
  }

  static let smallJson = """
  [
    {
        "id": "1",
        "name": "West Taniaside",
        "lat": "6.3141",
        "long": "105.6400"
    },
    {
        "id": "2",
        "name": "Devanteland",
        "lat": "-16.9626",
        "long": "116.6100"
    },
    {
        "id": "3",
        "name": "Lake Nat",
        "lat": "24.1279",
        "long": "-46.7845"
    },
    {
        "id": "4",
        "name": "Randalport",
        "lat": "5.6967",
        "long": "-85.2580"
    },
    {
        "id": "5",
        "name": "Johanburgh",
        "lat": "59.2685",
        "long": "174.6104"
    }
  ]
  """

  static let bigJson = """
  [
    {
        "id": "1",
        "name": "West Taniaside",
        "lat": "6.3141",
        "long": "105.6400"
    },
    {
        "id": "2",
        "name": "Devanteland",
        "lat": "-16.9626",
        "long": "116.6100"
    },
    {
        "id": "3",
        "name": "Lake Nat",
        "lat": "24.1279",
        "long": "-46.7845"
    },
    {
        "id": "4",
        "name": "Randalport",
        "lat": "5.6967",
        "long": "-85.2580"
    },
    {
        "id": "5",
        "name": "Johanburgh",
        "lat": "59.2685",
        "long": "174.6104"
    },
    {
        "id": "6",
        "name": "North Cortneyview",
        "lat": "13.9803",
        "long": "-125.7023"
    },
    {
        "id": "7",
        "name": "West Juanitaville",
        "lat": "71.7890",
        "long": "-130.6362"
    },
    {
        "id": "8",
        "name": "North Ashtyn",
        "lat": "89.5390",
        "long": "88.8471"
    },
    {
        "id": "9",
        "name": "Riceton",
        "lat": "86.9688",
        "long": "-37.2949"
    },
    {
        "id": "10",
        "name": "Armstrongmouth",
        "lat": "0.4188",
        "long": "146.7660"
    },
    {
        "id": "11",
        "name": "New Raulmouth",
        "lat": "5.5739",
        "long": "129.6450"
    },
    {
        "id": "12",
        "name": "Deionfurt",
        "lat": "9.9828",
        "long": "-3.1892"
    },
    {
        "id": "13",
        "name": "West Caesarfort",
        "lat": "4.1716",
        "long": "106.2489"
    },
    {
        "id": "14",
        "name": "Trevionborough",
        "lat": "28.5632",
        "long": "165.4086"
    },
    {
        "id": "15",
        "name": "New Simeontown",
        "lat": "45.6741",
        "long": "72.4326"
    },
    {
        "id": "16",
        "name": "Adamsstad",
        "lat": "10.7878",
        "long": "-19.1310"
    },
    {
        "id": "17",
        "name": "North Jaydenview",
        "lat": "77.1326",
        "long": "-6.7341"
    },
    {
        "id": "18",
        "name": "East Kristofferhaven",
        "lat": "-87.2070",
        "long": "81.3297"
    },
    {
        "id": "19",
        "name": "Hilllchester",
        "lat": "-51.3249",
        "long": "-22.2192"
    },
    {
        "id": "20",
        "name": "Edwardotown",
        "lat": "-38.3714",
        "long": "-65.6940"
    },
    {
        "id": "21",
        "name": "New Jaydontown",
        "lat": "19.7881",
        "long": "-21.8705"
    },
    {
        "id": "22",
        "name": "Sipesmouth",
        "lat": "-69.0435",
        "long": "60.7060"
    },
    {
        "id": "23",
        "name": "Boehmmouth",
        "lat": "75.1797",
        "long": "-72.4744"
    },
    {
        "id": "24",
        "name": "East Kenyaborough",
        "lat": "-55.3062",
        "long": "170.4315"
    },
    {
        "id": "25",
        "name": "Zoilafurt",
        "lat": "-26.1943",
        "long": "-156.5616"
    },
    {
        "id": "26",
        "name": "Justenchester",
        "lat": "39.9448",
        "long": "152.5858"
    },
    {
        "id": "27",
        "name": "Keithborough",
        "lat": "71.2821",
        "long": "-176.8080"
    },
    {
        "id": "28",
        "name": "North Ewellshire",
        "lat": "-79.6942",
        "long": "-153.2591"
    },
    {
        "id": "29",
        "name": "Harriston",
        "lat": "-89.3277",
        "long": "69.6555"
    },
    {
        "id": "30",
        "name": "Wittington",
        "lat": "-88.6641",
        "long": "-8.8934"
    },
    {
        "id": "31",
        "name": "Port Abdul",
        "lat": "80.8464",
        "long": "81.3726"
    },
    {
        "id": "32",
        "name": "Laynefort",
        "lat": "-49.2046",
        "long": "132.1507"
    },
    {
        "id": "33",
        "name": "Volkmanstad",
        "lat": "-30.3336",
        "long": "53.1277"
    },
    {
        "id": "34",
        "name": "Grantchester",
        "lat": "46.2144",
        "long": "159.4057"
    },
    {
        "id": "35",
        "name": "Lake Coratown",
        "lat": "74.0875",
        "long": "-151.4729"
    },
    {
        "id": "36",
        "name": "Howardview",
        "lat": "5.8622",
        "long": "-86.3698"
    },
    {
        "id": "37",
        "name": "New Lamontfurt",
        "lat": "-56.3325",
        "long": "-170.1642"
    },
    {
        "id": "38",
        "name": "Nickchester",
        "lat": "-21.1784",
        "long": "-1.6283"
    },
    {
        "id": "39",
        "name": "Lake Carloton",
        "lat": "70.9019",
        "long": "37.0624"
    },
    {
        "id": "40",
        "name": "West Laylaton",
        "lat": "45.8631",
        "long": "-139.3121"
    },
    {
        "id": "41",
        "name": "Sauerhaven",
        "lat": "-75.5979",
        "long": "-75.7364"
    },
    {
        "id": "42",
        "name": "Hellerport",
        "lat": "-50.4133",
        "long": "-168.7174"
    },
    {
        "id": "43",
        "name": "Maraview",
        "lat": "26.5542",
        "long": "64.0622"
    },
    {
        "id": "44",
        "name": "Cadenburgh",
        "lat": "42.3683",
        "long": "99.6801"
    },
    {
        "id": "45",
        "name": "Samantafurt",
        "lat": "-83.1466",
        "long": "-116.0591"
    },
    {
        "id": "46",
        "name": "Jaydemouth",
        "lat": "9.2495",
        "long": "90.3434"
    },
    {
        "id": "47",
        "name": "South Efrain",
        "lat": "-22.1517",
        "long": "50.6740"
    },
    {
        "id": "48",
        "name": "Siennaport",
        "lat": "-37.6504",
        "long": "160.0270"
    },
    {
        "id": "49",
        "name": "East Henry",
        "lat": "4.3522",
        "long": "147.7366"
    },
    {
        "id": "50",
        "name": "East Edwinatown",
        "lat": "-51.3681",
        "long": "15.1479"
    }
  ]
  """
}
