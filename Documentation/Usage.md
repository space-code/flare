* [Introduction](#introduction)
* [In-App Purchases](#in-app-purchases)
    - [Getting Products](#getting-products)
    - [Purchasing Product](#purchasing-product)
    - [Refreshing Receipt](#refreshing-receipt)
    - [Finishing Transaction](#finishing-transaction)
    - [Setup Observers](#setup-observers)
* [Errors](#handling-errors)
    - [IAPError](#iaperror)

## Introduction

Flare provides an elegant interface for In-App Purchases. It supports non-consumable and consumable purchases and subscriptions.

## In-App Purchases

### Getting Products

Before attempting to add a payment always check if the user can actually make payments. The `Flare` does it under the hood, if a user cannot make payments, you will get an `IAPError` with the value `paymentNotAllowed`.

The `fetch` method sends a request to the App Store, which retrieves the products if they are available. The `ids` parameter takes the product ids, which should be given from the App Store.

```swift
Flare.default.fetch(ids: Set(arrayLiteral: ["product_id"])) { result in
    switch result {
    case let .success(products):
        debugPrint("Fetched products: \(products)")
    case let .failure(error):
        debugPrint("An error occurred while fetching products: \(error.localizedDescription)")
    }
}
```

### Purchasing Product

The `buy` method performs a purchase of the product. The method accepts an `id` parameter which represents a product's id.

```swift
Flare.default.buy(id: "product_id") { result in 
    switch result {
    case let .success(transaction):
        debugPrint("A transaction was received: \(transaction)")
    case let .failure(error):
        debugPrint("An error occurred while purchasing product: \(error.localizedDescription)")
    }
}
```

### Refreshing Receipt

The `refresh` method refreshes the receipt, which represents the user's transactions with your app.

```swift
Flare.default.refresh { result in 
    switch result {
    case let .success(receipt):
        debugPrint("A receipt was received: \(receipt)")
    case let .failure(error):
        debugPrint("An error occurred while fetching receipt: \(error.localizedDescription)")
    }
}
```

### Finishing Transaction

The `finish` method removes a finished (i.e. failed or completed) transaction from the queue. 

```swift
Flare.default.finish(transaction: <transaction>)
```

### Setup Observers

The transactions array will only be synchronized with the server while the queue has observers. These methods may require that the user authenticate.
It is important to set an observer on this queue as early as possible after your app launch. Observer is responsible for processing all events triggered by the queue.

```swift
// Add transaction observer and handle payment transactions.
Flare.default.addTransactionObserver { result in
    switch result {
    case let .success(transaction):
        debugPrint("A transaction was received: \(transaction)")
    case let .failure(error):
        debugPrint("An error occurred while adding transaction observer: \(error.localizedDescription)")
    }
}
```

```swift
// Remove transaction observer.
Flare.default.removeTransactionObserver()
```

## Handling Errors

### IAPError

By default, all methods handlers in public interfaces produced the `IAPError` error type. The `IAPError` describes frequently used error types in the app.

```swift
public enum IAPError: Swift.Error {
    case emptyProducts
    case invalid(productIds: [String])
    case paymentNotAllowed
    case paymentCancelled
    case storeProductNotAvailable
    case storeTrouble
    case with(error: Swift.Error)
    case receiptNotFound
    case unknown
}
```

If you need a `SKError` you can just look at the `plainError` property in the `IAPError`.
