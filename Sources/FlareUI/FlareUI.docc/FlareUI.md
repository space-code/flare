# ``FlareUI``

Display a customizable in-app purchase store using StoreKit views for UIKit and SwiftUI.

## Overview

FlareUI provides UI to help you build a store for your in-app purchases, and provide a way for customers to complete the purchase. The views support localization, so your customers see the product names, descriptions, and prices appropriate to their App Store storefront.

## SwiftUI

The easiest way to display in-app purchases is by using ``SubscriptionsView`` and ``ProductsView``.

```swift
SubscriptionsView(ids: [com.company.subscription_id])
```

## UIKit

To present the in-app purchases from UIKit, use ``SubscriptionsViewController`` or ``ProductsViewController``.

```swift
let subscriptionsVC = SubscriptionsViewController(ids: [com.company.subscription_id])
let nav = UINavigationController(rootViewController: subscriptionsVC)
present(nav, animated: true)
```

## Minimum Requirements

| FlareUI | Date       | Swift | Xcode   | Platforms                                                   |
|---------|------------|-------|---------|-------------------------------------------------------------|
| 3.1.0   | 06/04/2025 | 5.7   | 16.0    | iOS 13.0, watchOS 6.0, macOS 10.15, tvOS 13.0, visionOS 1.0 |
| 3.0.2   | 04/09/2024 | 5.7   | 14.1    | iOS 13.0, watchOS 6.0, macOS 10.15, tvOS 13.0, visionOS 1.0 |
| 3.0.1   | 09/08/2024 | 5.7   | 14.1    | iOS 13.0, watchOS 6.0, macOS 10.15, tvOS 13.0, visionOS 1.0 |
| 3.0     | 15/06/2024 | 5.7   | 14.1    | iOS 13.0, macOS 10.15, tvOS 13.0                            |

## License

flare is available under the MIT license. See the LICENSE file for more info.
