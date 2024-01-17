![Flare: In-app purchases and subscriptions made easy](https://raw.githubusercontent.com/space-code/flare/dev/Resources/flare.png)

<h1 align="center" style="margin-top: 0px;">flare</h1>

<p align="center">
<a href="https://github.com/space-code/flare/blob/main/LICENSE"><img alt="Licence" src="https://img.shields.io/cocoapods/l/service-core.svg?style=flat"></a> 
<a href="https://swiftpackageindex.com/space-code/flare"><img alt="Swift Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fflare%2Fbadge%3Ftype%3Dswift-versions"/></a> 
<a href="https://swiftpackageindex.com/space-code/flare"><img alt="Platform Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fflare%2Fbadge%3Ftype%3Dplatforms"/></a> 
<a href="https://github.com/space-code/flare"><img alt="CI" src="https://github.com/space-code/flare/actions/workflows/ci.yml/badge.svg?branch=main"></a>
<a href="https://codecov.io/gh/space-code/flare"><img alt="CodeCov" src="https://codecov.io/gh/space-code/flare/graph/badge.svg?token=WUWUSKQZWY"></a>
<a href="https://github.com/apple/swift-package-manager" alt="Flare on Swift Package Manager" title="Flare on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
<a href="https://codecov.io/gh/space-code/flare"><img alt="GitHub release; latest by date" src="https://img.shields.io/github/v/release/space-code/flare"></a>
<a href="https://codecov.io/gh/space-code/flare"><img alt="GitHub commit activity" src="https://img.shields.io/github/commit-activity/m/space-code/flare"></a>
</p>

## Description
Flare is a framework written in Swift that makes it easy for you to work with in-app purchases and subscriptions.

- [Features](#features)
- [Documentation](#documentation)
- [Requirements](#requirements)
- [Installation](#installation)
- [Communication](#communication)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## Features
- [x] Support Consumable & Non-Consumable Purchases
- [x] Support Subscription Purchase
- [x] Support Promotional & Introductory Offers
- [x] iOS, tvOS, watchOS, macOS, and visionOS compatible
- [x] Complete Unit Test & Integration Coverage

## Documentation
Check out [flare documentation](https://space-code.github.io/flare/documentation/flare/).

## Requirements
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 7.0+ / visionOS 1.0+
- Xcode 14.0
- Swift 5.7

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but `flare` does support its use on supported platforms.

Once you have your Swift package set up, adding `flare` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/space-code/flare.git", .upToNextMajor(from: "2.0.0"))
]
```

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributing
Bootstrapping development environment

```
make bootstrap
```

Please feel free to help out with this project! If you see something that could be made better or want a new feature, open up an issue or send a Pull Request!

## Author
Nikita Vasilev, nv3212@gmail.com

## License
flare is available under the MIT license. See the LICENSE file for more info.
