// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable all

import PackageDescription

let package = Package(
    name: "Flare",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v7),
        .tvOS(.v13),
    ],
    products: [
        .library(name: "Flare", targets: ["Flare"]),
    ],
    dependencies: [
        .package(url: "https://github.com/space-code/concurrency.git", .upToNextMajor(from: "0.0.1")),
        .package(url: "https://github.com/space-code/objects-factory.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "Flare",
            dependencies: [
                .product(name: "Concurrency", package: "concurrency"),
            ]
        ),
        .testTarget(
            name: "FlareTests",
            dependencies: [
                "Flare",
                .product(name: "ObjectsFactory", package: "objects-factory"),
                .product(name: "TestConcurrency", package: "concurrency"),
            ]
        ),
    ]
)
