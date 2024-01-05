# Restore Purchase

Learn how to restore a purchase.

## Overview

Users sometimes need to restore purchased content, such as when they upgrade to a new phone. Include some mechanism in your app, such as a Restore Purchases button, to let them restore their purchases.

## Refresh the app receipt

A request to the App Store to get the app receipt, which represents the user’s transactions with your app.

> note: The receipt isn’t necessary if you use StoreKit2. Only use the receipt if your app supports deployment target is lower than iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0. 

Use this API to request a new app receipt from the App Store if the receipt is invalid or missing from its expected location. To request the receipt using the ``IFlare/receipt(completion:)``.

> important: The receipt refresh request displays a system prompt that asks users to authenticate with their App Store credentials. For a better user experience, initiate the request after an explicit user action, like tapping or clicking a button.

```swift
Flare.default.receipt { result in 
    switch result {
    case let .success(receipt):
        // Handle a receipt
    case let .failure(error):
        // Handle an error
    }
}
```

> important: If a receipt isn't found, Flare throws an ``IAPError/receiptNotFound`` error.

There is an ``IFlare/receipt()`` method for obtaining a receipt using async/await.

```swift
let receipt = try await Flare.default.receipt()
```
