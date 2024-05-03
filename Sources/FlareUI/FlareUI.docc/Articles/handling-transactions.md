# Handling Transactions

Learn how to handle transactions.

## Overview

If you have restorable products, the `ProductsView` can show a restore button to the customer. For this, you can use ``SwiftUI/View/onInAppPurchaseCompletion(completion:)`` or ``ProductsViewController/onInAppPurchaseCompletion``.

```swift
ProductsView(ids: ["com.company.product_id_1", "com.company.product_id_2"])
    .onInAppPurchaseCompletion { result in
        switch result {
        case let .success(transaction):
            // Handle the transaction
        case let .failure(error):
            // Handle the error
        }
    }
```
