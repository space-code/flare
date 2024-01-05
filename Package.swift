// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable all

import PackageDescription

let visionOSSetting: SwiftSetting = .define("VISION_OS", .when(platforms: [.visionOS]))

let package = Package(
    name: "Flare",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v7),
        .tvOS(.v13),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "Flare", targets: ["Flare"]),
    ],
    dependencies: [
        .package(url: "https://github.com/space-code/concurrency.git", .upToNextMajor(from: "0.0.1")),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "Flare",
            dependencies: [
                .product(name: "Concurrency", package: "concurrency"),
            ],
            swiftSettings: [visionOSSetting]
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
