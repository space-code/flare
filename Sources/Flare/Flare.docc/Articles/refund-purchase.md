# Refund Purchase

Learn how to process a refund through an iOS app.

## Refund a Purchase

Starting with iOS 15, Flare now includes support for refunding purchases as part of StoreKit 2. Under the hood, `Flare` obtains the active window scene and displays the sheets on it. You can read more about the refunding process in the official [Apple documentation](https://developer.apple.com/documentation/storekit/transaction/3803220-beginrefundrequest/).

Flare suggest to use ``IFlare/beginRefundRequest(productID:)`` for refunding purchase.

```swift
let status = try await Flare.shared.beginRefundRequest(productID: "product_id")
```

> important: If an issue occurs during the refund process, this method throws an ``IAPError/refund(error:)`` error.

Call this function from account settings or a help menu to enable customers to request a refund for an in-app purchase within your app. When you call this function, the system displays a refund sheet with the customer’s purchase details and list of reason codes for the customer to choose from.
