// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swiftlint:disable all

import PackageDescription

let visionOSSetting: SwiftSetting = .define("VISION_OS", .when(platforms: [.visionOS]))

let package = Package(
    name: "Flare",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v7),
        .tvOS(.v13),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "Flare", targets: ["Flare"]),
        .library(name: "FlareUI", targets: ["FlareUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/space-code/concurrency.git", .upToNextMajor(from: "0.0.1")),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
        .package(url: "https://github.com/space-code/log.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/space-code/atomic.git", .upToNextMajor(from: "1.0.0")),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing",
            from: "1.15.3"
        ),
    ],
    targets: [
        .target(
            name: "Flare",
            dependencies: [
                .product(name: "Atomic", package: "atomic"),
                .product(name: "Concurrency", package: "concurrency"),
                .product(name: "Log", package: "log"),
            ],
            resources: [.process("Resources")],
            swiftSettings: [visionOSSetting]
        ),
        .target(
            name: "FlareUI",
            dependencies: ["Flare"],
            resources: [.process("Resources")]
        ),
        .target(name: "FlareMock", dependencies: ["Flare"]),
        .target(name: "FlareUIMock", dependencies: ["FlareMock", "FlareUI"]),
        .testTarget(
            name: "FlareTests",
            dependencies: [
                "Flare",
                "FlareMock",
                .product(name: "TestConcurrency", package: "concurrency"),
            ]
        ),
        .testTarget(
            name: "FlareUITests",
            dependencies: [
                "FlareUI",
                "FlareMock",
                "FlareUIMock",
            ]
        ),
        .testTarget(
            name: "SnapshotTests",
            dependencies: [
                "Flare",
                "FlareUIMock",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
    ]
)
