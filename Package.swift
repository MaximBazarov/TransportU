// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TransportU",
    products: [
        .library(
            name: "TransportU",
            targets: ["TransportU"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Unicore/PromiseU", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "TransportU",
            dependencies: ["PromiseU"]),
        .testTarget(
            name: "TransportUTests",
            dependencies: ["PromiseU","TransportU"]),
    ]
)
