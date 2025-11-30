![Flare: In-app purchases and subscriptions made easy](https://raw.githubusercontent.com/space-code/flare/dev/Resources/flare.png)

<h1 align="center" style="margin-top: 0px;">flare</h1>

<p align="center">
<a href="https://github.com/space-code/flare/blob/main/LICENSE"><img alt="Licence" src="https://img.shields.io/cocoapods/l/service-core.svg?style=flat"></a> 
<a href="https://swiftpackageindex.com/space-code/flare"><img alt="Swift Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fflare%2Fbadge%3Ftype%3Dswift-versions"/></a> 
<a href="https://swiftpackageindex.com/space-code/flare"><img alt="Platform Compatibility" src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fspace-code%2Fflare%2Fbadge%3Ftype%3Dplatforms"/></a> 
<a href="https://github.com/space-code/flare/actions/workflows/flare.yml"><img alt="Flare CI" src="https://github.com/space-code/flare/actions/workflows/flare.yml/badge.svg?branch=main"></a>
<a href="https://github.com/space-code/flare/actions/workflows/flare-ui.yml"><img alt="FlareUI CI" src="https://github.com/space-code/flare/actions/workflows/flare-ui.yml/badge.svg?branch=main"></a>
<a href="https://codecov.io/gh/space-code/flare"><img alt="CodeCov" src="https://codecov.io/gh/space-code/flare/graph/badge.svg?token=WUWUSKQZWY"></a>
<a href="https://github.com/apple/swift-package-manager" alt="Flare on Swift Package Manager" title="Flare on Swift Package Manager"><img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" /></a>
</p>

## Description

Flare is a modern, lightweight Swift framework that simplifies working with in-app purchases and subscriptions. Built on top of StoreKit and StoreKit 2, it provides a clean, unified API with async/await support and includes ready-to-use UI components for seamless integration across all Apple platforms.

## ✨ Features

- 🛍️ **Complete Purchase Support** - Consumable, non-consumable, and subscription purchases
- 🎁 **Promotional Offers** - Support for promotional and introductory offers
- ⚡ **Modern Swift** - Built with async/await for clean, readable code
- 🔄 **StoreKit 1 & 2** - Unified API supporting both StoreKit versions
- 🎨 **UI Components** - Pre-built SwiftUI and UIKit views for product displays
- 📱 **Cross-Platform** - iOS, tvOS, watchOS, macOS, and visionOS compatible
- 🧪 **Thoroughly Tested** - Complete unit, integration, and snapshot test coverage
- 📦 **Zero Dependencies** - Lightweight with no external dependencies

## 📋 Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
  - [Fetching Products](#fetching-products)
  - [Making Purchases](#making-purchases)
  - [Managing Subscriptions](#managing-subscriptions)
  - [Handling Transactions](#handling-transactions)
  - [Promotional Offers](#promotional-offers)
- [FlareUI](#flareui)
  - [SwiftUI Integration](#swiftui-integration)
  - [UIKit Integration](#uikit-integration)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)

## 📱 Requirements

| Package | Supported Platforms | Xcode | Minimum Swift Version |
|---------|-------------------|-------|----------------------|
| **Flare** | iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 7.0+ / visionOS 1.0+ | 15.3+ | 5.10 |
| **FlareUI** | iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ | 15.3+ | 5.10 |

## 🚀 Installation

### Swift Package Manager

Add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/space-code/flare.git", .upToNextMajor(from: "3.1.0"))
]
```

**Or via Xcode:**

1. File > Add Package Dependencies
2. Enter package URL: `https://github.com/space-code/flare.git`
3. Select version requirements

The package contains two libraries:
- **Flare** - Core in-app purchase functionality
- **FlareUI** - Ready-to-use UI components for SwiftUI and UIKit

## Quick Start

```swift
import Flare

// Fetch products
let products = try await Flare.shared.fetch(productIDs: ["premium_monthly"])

// Purchase a product
let transaction = try await Flare.shared.purchase(product: products.first!)

// Finish the transaction
Flare.shared.finish(transaction: transaction, completion: nil)
```

## Usage

### Fetching Products

Retrieve product information from the App Store:

```swift
import Flare

// Fetch single product
let productIDs = ["com.app.premium"]
let products = try await Flare.shared.fetch(productIDs: productIDs)

// Fetch multiple products
let subscriptionIDs = [
    "com.app.monthly",
    "com.app.yearly",
    "com.app.lifetime"
]
let subscriptions = try await Flare.shared.fetch(productIDs: subscriptionIDs)

// Access product details
for product in products {
    print("Product: \(product.localizedTitle)")
    print("Price: \(product.localizedPriceString)")
    print("Description: \(product.localizedDescription)")
}
```

### Making Purchases

Handle purchases with simple async/await syntax:

```swift
import Flare

 func purchasePremium() async throws {
    let productID = "com.app.premium"

    let products = try await Flare.shared.fetch(productIDs: [productID])

    guard let product = products.first else {
        throw IAPError.storeProductNotAvailable
    }
        
    do {
        let transaction = try await Flare.shared.purchase(product: product)
        await unlockPremiumFeatures()
        Flare.shared.finish(transaction: transaction, completion: nil)
    } catch {
        guard let error = error as? IAPError else { return }
            
        switch error {
        case .paymentCancelled:
            print("❌ User cancelled the purchase")
        default:
            print("❌ Purchase failed: \(error)")
        }
    }
}
```

### Managing Subscriptions

Work with subscription products and their states:

```swift
import Flare

func purchaseSubscription(product: StoreProduct) async throws {
    do {
        let transaction = try await Flare.shared.purchase(product: product)
        Flare.shared.finish(transaction: transaction, completion: nil)
    } catch {
        guard let error = error as? IAPError else { return }
        // Handle the error
    }
}
```

### Handling Transactions

Manage transaction lifecycle:

```swift
import Flare

// Finish a transaction after delivering content
func completeTransaction(_ transaction: Transaction) {
    Flare.shared.finish(transaction: transaction) {
        print("✅ Transaction completed successfully")
    }
}

// Restore previous purchases
func restorePurchases() async throws {
    do {
        try await Flare.shared.restore()
        print("✅ Purchases restored successfully")
    } catch {
        print("❌ Failed to restore purchases: \(error)")
    }
}

// Listen for transaction updates
func observeTransactions() {
    Flare.shared.addTransactionObserver { result in
        switch result {
        case let .success(transaction):
            handleTransaction(transaction)
        case let .failure(error):
            print("Transaction error: \(error)")
        }
    }
}
```

### Promotional Offers

Support promotional and introductory offers:

```swift
import Flare

func purchaseWithOffer(product: StoreProduct, offer: PromotionalOffer) async throws {
    do {
        let transaction = try await Flare.shared.purchase(
            product: product,
            promotionalOffer: offer
        )
            
        print("✅ Purchased with promotional offer!")
        Flare.shared.finish(transaction: transaction, completion: nil)
    } catch {
        guard let error = error as? IAPError else { return }
        // Handle the error
    }
}
```

## 🎨 FlareUI

FlareUI provides ready-to-use UI components for displaying products and handling purchases in both SwiftUI and UIKit.

### SwiftUI Integration

Display products with built-in SwiftUI views:

```swift
import SwiftUI
import FlareUI

struct StoreView: View {
    var body: some View {
        NavigationView {
            SubscriptionsView(ids: ["com.product.subscription"])
                .navigationTitle("Premium Features")
        }
    }
}
```

### UIKit Integration

Integrate with UIKit applications:

```swift
import UIKit
import FlareUI

let subscriptionsVC = SubscriptionsViewController(ids: [com.company.subscription_id])
let nav = UINavigationController(rootViewController: subscriptionsVC)
present(nav, animated: true)
```

## Documentation

Comprehensive documentation is available:

- **[Flare Documentation](https://space-code.github.io/flare/flare/documentation/flare/)** - Core framework integration and APIs
- **[FlareUI Documentation](https://space-code.github.io/flare/flareui/documentation/flareui/)** - UI components, customization, and integration guides

## Contributing

We love contributions! Please read our [Contributing Guide](CONTRIBUTING.md) to learn about our development process, how to propose bugfixes and improvements, and how to build and test your changes.

### Development Setup

Bootstrap the development environment:

```bash
mise install
```

### Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Author

**Nikita Vasilev**
- Email: [nv3212@gmail.com](mailto:nv3212@gmail.com)
- GitHub: [@ns-vasilev](https://github.com/ns-vasilev)

## License

Flare is released under the MIT license. See [LICENSE](LICENSE) for details.

---

<div align="center">

**[⬆ back to top](#validator)**

Made with ❤️ by [space-code](https://github.com/space-code)

</div>