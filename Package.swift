// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Flare",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v11),
    ],
    products: [
        .library(
            name: "Flare",
            targets: ["Flare"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Flare",
            dependencies: []),
        .testTarget(
            name: "FlareTests",
            dependencies: ["Flare"]),
    ]
)
