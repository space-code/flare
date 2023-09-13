// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Flare",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v7),
        .tvOS(.v11),
    ],
    products: [
        .library(name: "Flare", targets: ["Flare"]),
    ],
    dependencies: [
        .package(url: "https://github.com/space-code/concurrency.git", .upToNextMajor(from: "0.0.1")),
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
                .product(name: "TestConcurrency", package: "concurrency"),
            ]
        ),
    ]
)
