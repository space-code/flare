# Documentation

### Overview

* [Introduction](#introduction)
* [Flare Diagram](#diagram)
* [In-App Purchases](#in-app-purchases)
    - [Getting Products](#getting-products)
    - [Purchasing Product](#purchasing-product)
    - [Refreshing Receipt](#refreshing-receipt)
    - [Finishing Transaction](#finishing-transaction)
    - [Setup Observers](#setup-observers)
* [Errors](#handling-errors)
    - [IAPError](#iaperror)

## Introduction

Flare provides an elegant interface for In-App Purchases, supporting non-consumable and consumable purchases as well as subscriptions.

## Flare Diagram

![Flare: Components](https://raw.githubusercontent.com/space-code/flare/dev/Documentation/Resources/flare.png)

`Flare` is a central component that serves as the client API for managing various aspects of in-app purchases and payments in your application. It is designed to simplify the integration of payment processing and in-app purchase functionality into your software.
`IAPProvider` is a fundamental component of `Flare` that handles all in-app purchase operations. It offers an API to initiate, verify, and manage in-app purchases within your application. 
`IPaymentProvider` is a central component in `Flare` that orchestrates various payment-related operations within your application. It acts as the bridge between the payment gateway and your app's logic. 
`IProductProvider` is a component of `Flare` that helps managing the products or services available for purchase within your app.
`IReceiptRefreshProvider` is responsible for refreshing and managing receipt associated with in-app purchases. 
`IAppStoreReceiptProvider` manages and provides access to the app's receipt, which contains a record of all in-app purchases made by the user.

## In-App Purchases

### Getting Products

Before attempting to add a payment always check if the user can actually make payments. The `Flare` does it under the hood, if a user cannot make payments, you will get an `IAPError` with the value `paymentNotAllowed`.

The `fetch` method sends a request to the App Store, which retrieves the products if they are available. The `productIDs` parameter takes the product ids, which should be given from the App Store.

```swift
Flare.default.fetch(productIDs: Set(arrayLiteral: ["product_id"])) { result in
    switch result {
    case let .success(products):
        debugPrint("Fetched products: \(products)")
    case let .failure(error):
        debugPrint("An error occurred while fetching products: \(error.localizedDescription)")
    }
}
```

Additionally, there are versions of both `fetch` that provide an `async` method, allowing the use of `await`.

```swift
    do {
        let products = try await Flare.default.fetch(productIDs: Set(arrayLiteral: ["product_id"]))
    } catch {
        debugPrint("An error occurred while fetching products: \(error.localizedDescription)")
    }
```

### Purchasing Product

The `purchase` method performs a purchase of the product. The method accepts an `productID` parameter which represents a product's id.

```swift
Flare.default.purchase(productID: "product_id") { result in 
    switch result {
    case let .success(transaction):
        debugPrint("A transaction was received: \(transaction)")
    case let .failure(error):
        debugPrint("An error occurred while purchasing product: \(error.localizedDescription)")
    }
}
```

You can also use the `async/await` implementation of the `purchase` method.

```swift
    do {
        let products = try await Flare.default.purchase(productID: "product_id")
    } catch {
        debugPrint("An error occurred while purchasing product: \(error.localizedDescription)")
    }
```

### Refreshing Receipt

The `refresh` method refreshes the receipt, representing the user's transactions with your app.

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

You can also use the `async/await` implementation of the `refresh` method.

```swift
    do {
        let receipt = try await Flare.default.refresh()
    } catch {
        debugPrint("An error occurred while fetching receipt: \(error.localizedDescription)")
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
// Adds transaction observer to the payment queue and handles payment transactions.
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
// Removes transaction observer from the payment queue.
Flare.default.removeTransactionObserver()
```

## Handling Errors

### IAPError

By default, all methods handlers in public interfaces produced the `IAPError` error type. The `IAPError` describes frequently used error types in the app.

```swift
/// `IAPError` is the error type returned by Flare.
/// It encompasses a few different types of errors, each with their own associated reasons.
public enum IAPError: Swift.Error {
    /// The empty array of products were fetched.
    case emptyProducts
    /// The attempt to fetch products with invalid identifiers.
    case invalid(productIds: [String])
    /// The attempt to purchase a product when payments are not allowed.
    case paymentNotAllowed
    /// The payment was cancelled.
    case paymentCancelled
    /// The attempt to fetch a product that doesn't available.
    case storeProductNotAvailable
    /// The `SKPayment` returned unknown error.
    case storeTrouble
    /// The operation failed with an underlying error.
    case with(error: Swift.Error)
    /// The App Store receipt wasn't found.
    case receiptNotFound
    /// The unknown error occurred.
    case unknown
}
```

If you need a `SKError`, you can simply look at the `plainError` property in the `IAPError`.
