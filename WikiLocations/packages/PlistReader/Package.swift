// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "PlistReader",
  products: [
    .library(
      name: "PlistReader",
      targets: ["PlistReader"]
    ),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "PlistReader",
      dependencies: []
    ),
    .testTarget(
      name: "PlistReaderTests",
      dependencies: ["PlistReader"]
    ),
  ]
)
