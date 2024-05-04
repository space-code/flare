# Handling Transactions

Learn how to handle transactions.

## Overview

Views provide a handy way to handle completed or failed transactions using ``SwiftUI/View/onInAppPurchaseCompletion(completion:)`` or ``ProductsViewController/onInAppPurchaseCompletion``.

```swift
// SwiftUI

ProductsView(ids: ["com.company.product_id_1", "com.company.product_id_2"])
    .onInAppPurchaseCompletion { result in
        switch result {
        case let .success(transaction):
            // Handle the transaction

            // IMPORTANT: Finish the transaction
        case let .failure(error):
            // Handle the error
        }
    }
```

> important: Once you've handled a transaction, don't forget to finish it using [Finish Method](https://space-code.github.io/flare/flare/documentation/flare/iflare/finish(transaction:completion:)). Read more about [Finishing Transactions](https://space-code.github.io/flare/flare/documentation/flare/perform-purchase).

```swift
// UIKit

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1"])
subscriptionsVC.onInAppPurchaseCompletion = { result in 
    switch result {
    case let .success(transaction):
        // Handle the transaction

        // IMPORTANT: Finish the transaction
    case let .failure(error):
        // Handle the error
    }
}
```
