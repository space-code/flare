# ``Flare``

Flare provides an elegant interface for In-App Purchases, supporting non-consumable and consumable purchases as well as subscriptions.

## Overview

Flare provides a clear and convenient API for making in-app purchases.

```swift
import Flare

/// Fetch a product with the given id
guard let product = try await Flare.shared.products(productIDs: ["product_identifier"]) else { return }
/// Purchase a product
let transaction = try await Flare.shared.purchase(product: product)
/// Finish a transaction
Flare.shared.finish(transaction: transaction, completion: nil)
```

Flare supports both StoreKit and StoreKit2; it decides which one to use under the hood based on the operating system version. Flare provides two ways to work with in-app purchases (IAP): it supports the traditional closure-based syntax and the modern async/await approach.

```swift
import Flare

/// Fetch a product with the given id
Flare.shared.products(productIDs: ["product_identifier"]) { result in 
    switch result {
        case let .success(products):
            // Purchase a product
        case let .failure(error):
            // Handler an error
    }
}
```

## Minimum Requirements

| Flare | Date       | Swift | Xcode   | Platforms                                                   |
|-------|------------|-------|---------|-------------------------------------------------------------|
| 3.0   | 15/06/2024 | 5.7   | 14.1    | iOS 13.0, watchOS 6.0, macOS 10.15, tvOS 13.0, visionOS 1.0 |
| 2.0   | 14/09/2023 | 5.7   | 14.1    | iOS 13.0, watchOS 6.0, macOS 10.15, tvOS 13.0, visionOS 1.0 |
| 1.0   | 21/01/2023 | 5.5   | 13.4.1  | iOS 13.0, watchOS 6.0, macOS 10.15, tvOS 13.0               |

## License

flare is available under the MIT license. See the LICENSE file for more info.

## Topics

### Essentials

- ``IFlare``
- ``IIAPProvider``

### Misc

- ``IAPError``
- ``ProductType``
- ``StoreProduct``
- ``StoreTransaction``

### Articles

- <doc:perform-purchase>
- <doc:restore-purchase>
- <doc:refund-purchase>
- <doc:promotional-offers>
- <doc:logging>
