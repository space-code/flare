# Perform Purchase

Learn how to perform a purchase.

## Setup Observers

The transactions array will only be synchronized with the server while the queue has observers. These methods may require that the user authenticate. It is important to set an observer on this queue as early as possible after your app launch. Observer is responsible for processing all events triggered by the queue.

The closure emits a transaction when the system creates or updates transactions that occur outside of the app or on other devices.

```swift
// Adds transaction observer to the payment queue and handles payment transactions.
Flare.shared.addTransactionObserver { result in
    switch result {
    case let .success(transaction):
        debugPrint("A transaction was received: \(transaction)")
    case let .failure(error):
        debugPrint("An error occurred while adding transaction observer: \(error.localizedDescription)")
    }
}
```

```swift
// Removes transaction observer from the payment queue.
Flare.shared.removeTransactionObserver()
```

## Getting Products

The fetch method sends a request to the App Store, which retrieves the products if they are available. The productIDs parameter takes the product ids, which should be given from the App Store.

> important: Before attempting to add a payment always check if the user can actually make payments. The Flare does it under the hood, if a user cannot make payments, you will get an ``IAPError/paymentNotAllowed``.

```swift
Flare.shared.fetch(productIDs: ["product_id"]) { result in
    switch result {
    case let .success(products):
        debugPrint("Fetched products: \(products)")
    case let .failure(error):
        debugPrint("An error occurred while fetching products: \(error.localizedDescription)")
    }
}
```

Additionally, there is an `await` version of the ``IFlare/fetch(productIDs:)`` method.

```swift
do {
    let products = try await Flare.shared.fetch(productIDs: Set(arrayLiteral: ["product_id"]))
} catch {
    debugPrint("An error occurred while fetching products: \(error.localizedDescription)")
}
```

> note: Products are cached by default. If caching is not possible for specific usecases, set ``Configuration/fetchCachePolicy`` to ``FetchCachePolicy/fetch``.

```swift
import Flare

let configuration = Configuration(fetchCachePolicy: .fetch)

Flare.configure(with: configuration)
```

## Purchasing Product

Flare provides a few methods to perform a purchase:

- ``IFlare/purchase(product:completion:)``
- ``IFlare/purchase(product:)``
- ``IFlare/purchase(product:options:)``
- ``IFlare/purchase(product:options:completion:)``

The method accepts a product parameter which represents a product:

```swift
Flare.shared.purchase(product: product) { result in 
    switch result {
    case let .success(transaction):
        debugPrint("A transaction was received: \(transaction)")
    case let .failure(error):
        debugPrint("An error occurred while purchasing product: \(error.localizedDescription)")
    }
}
```

If your app has a deployment target higher than iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, you can pass a set of [`options`](https://developer.apple.com/documentation/storekit/product/purchaseoption) along with a purchase request.

```swift
let transaction = try await Flare.shared.purchase(product: product, options: [.appAccountToken(UUID())])
```

## Finishing Transaction

Finishing a transaction tells StoreKit that your app completed its workflow to make a purchase complete. Unfinished transactions remain in the queue until they’re finished, so be sure to add the transaction queue observer every time your app launches, to enable your app to finish the transactions. Your app needs to finish each transaction, whether it succeeds or fails.

To finish the transaction, call the ``IFlare/finish(transaction:completion:)`` method.

```swift
Flare.shared.finish(transaction: transaction, completion: nil)
```

> important: Don’t call the ``IFlare/finish(transaction:completion:)`` method before the transaction is actually complete and attempt to use some other mechanism in your app to track the transaction as unfinished. StoreKit doesn’t function that way, and doing that prevents your app from downloading Apple-hosted content and can lead to other issues.
