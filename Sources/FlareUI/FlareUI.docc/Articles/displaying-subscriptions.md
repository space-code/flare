# Displaying Subscriptions

Learn how to display a set of subscriptions to a user.

## Overview

The `FlareUI` provides a way to display subscriptions to a customer. To display a set of products to the user, simply pass a collection of identifiers to the ``SubscriptionsView`` or ``SubscriptionsViewController``.

```swift
SubscriptionsView(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
```

![SubscriprionsView](subscription_view.png)

Once `SubscriptionsView` fetches these subscriptions from the App Store, it will display them to the user. If the subscriptions can't be fetched for any reason, the `SubscriptionsView` shows a message to the user that the App Store is not available.

> important: By default, all Flare views use cached data if available; otherwise, they fetch the data. If you want to change this behavior, please read more about Flare configuration [here](https://space-code.github.io/flare/flare/documentation/flare/caching).

## UIKit

The `FlareUI` package provides wrappers for the UIKit views. It can be easily integrated into UIKit environments using ``SubscriptionsViewController``.

```swift
let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
let nav = UINavigationController(rootViewController: subscriptionsVC)
present(nav, animated: true)
```

The `SubscriptionsViewController` is backed by `SubscriptionsView`, and its behavior is the same.

## Customization 

``SubscriptionsViewController`` and ``SubscriptionsView`` provide a set of properties and methods to change the style, handle transactions, and more.

### Handling a Completion Result

You can handle a completion of a purchase using ``SubscriptionsViewController/onInAppPurchaseCompletion`` and ``SubscriptionsView/onInAppPurchaseCompletion(completion:)``.

> note: You can read more about [How to Handle Transactions](<doc:handling-transactions>).

```swift
// SwiftUI

SubscriptionsView(ids: ["com.company.subscription_id_1"])
    .onInAppPurchaseCompletion { result in 
        switch result {
        case let .success(transaction):
            // Handle the transaction
        case let .failure(error):
            // Handle the error
        }
    }
```

```swift
// UIKit

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1"])
subscriptionsVC.onInAppPurchaseCompletion = { result in 
    switch result {
    case let .success(transaction):
        // Handle the transaction
    case let .failure(error):
        // Handle the error
    }
}
```

### Passing Custom Parameters

Starting from iOS 15.0, macOS 12.0, and tvOS 15.0, you can pass extracted parameters to the purchase for a specific product. Use ``SwiftUI/View/inAppPurchaseOptions(_:)`` or ``SubscriptionsViewController/inAppPurchaseOptions(_:)``.

> note: You can read more about [Purchase Options](https://developer.apple.com/documentation/storekit/product/purchaseoption).

```swift
// SwiftUI

SubscriptionsView(ids: ["com.company.subscription_id_1"])
    .inAppPurchaseOptions { product in
        return .init(options: [.appAccountToken(UUID())])
    }
```

```swift
// UIKit

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1"])
subscriptionsVC.inAppPurchaseOptions { product in
    return .init(options: [.appAccountToken(UUID())])
}
```

### Subscription Control Style 

You can change the default style of subscription items using ``SwiftUI/View/subscriptionControlStyle(_:)`` or ``SubscriptionsViewController/subscriptionControlStyle``.

![SubscriprionsView](button_styles.png)

> note: If you want to create a custom style for subscription, you can read about this more [here](<doc:creating-custom-product-style>).

### Subscription Background Color

By default, ``SubscriptionsView`` and ``SubscriptionsViewController`` provide a default background color. In case you want to change its background color use ``SubscriptionsView/subscriptionBackground(_:)`` or ``SubscriptionsViewController/subscriptionBackgroundColor``.

```swift
// SwiftUI

SubscriptionsView(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
    .subscriptionBackground(Color.blue)
```

```swift
// UIKit

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
subscriptionsVC.subscriptionBackgroundColor = .blue
```

> note: To change a header background use ``SwiftUI/View/subscriptionHeaderContentBackground(_:)`` or ``SubscriptionsViewController/subscriptionHeaderContentBackground``.

### Tint Color

To change a tint color of a view, use ``SwiftUI/View/tintColor(_:)`` or ``SubscriptionsViewController/subscriptionViewTintColor``.

```swift
// SwiftUI

SubscriptionsView(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
    .tintColor(Color.blue)
```

```swift
// UIKit

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
subscriptionsVC.subscriptionViewTintColor = .blue
```

### Button Label Style

You can change the style of a button's label using ``SwiftUI/View/subscriptionButtonLabel(_:)`` or ``SubscriptionsViewController/subscriptionButtonLabelStyle``.

### Marketing Content

To provide a custom header for a subscription view, use the ``SubscriptionsViewController/subscriptionMarketingContnentView`` or ``SubscriptionsView/subscriptionMarketingContent(view:)`` property.

```swift
// SwiftUI

var headerView: some View { ... }

SubscriptionsView(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
    .subscriptionMarketingContent(headerView)
```

```swift
// UIKit

let headerView: UIView = ...

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
subscriptionsVC.subscriptionHeaderView = headerView
```

## Custom Buttons

### Restore Button

If you want to get a way to restore subscription to a user, the `SubscriptionsView` can show a restore button to the customer. For this, you can use ``SwiftUI/View/storeButton(_:types:)-4x8yd`` or ``SubscriptionsViewController/storeButton(_:types:)``.

```swift
// SwiftUI

SubscriptionsView(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
    .storeButton(.visible, types: .restore)
```

```swift
// UIKit

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
subscriptionsVC.storeButton(.visible, types: [.restore])
```

### Terms of Service and Privacy Policy Buttons

Also, you can provide buttons for the terms of service and privacy policy. There are two ways to do it: you can provide a URL to a webpage with content or pass a custom view that displays this information.

To provide URLs to these pages, use ``SwiftUI/View/subscriptionTermsOfServiceURL(_:)`` and ``SwiftUI/View/subscriptionPrivacyPolicyURL(_:)``.

```swift
// SwiftUI

SubscriptionsView(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
    .storeButton(.visible, types: .policies)
    .subscriptionTermsOfServiceURL(URL(string: "An URL to terms of service page")!)
    .subscriptionPrivacyPolicyURL(URL(string: "An URL to privacy policy page)!)
```

To provide custom views, use ``SwiftUI/View/subscriptionTermsOfServiceDestination(content:)`` and ``SwiftUI/View/subscriptionPrivacyPolicyDestination(content:)``.

```swift
// SwiftUI

var termsOfServiceView: some View { ... }
var privacyPolicyView: some View { ... }

SubscriptionsView(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])
    .storeButton(.visible, types: .policies)
    .subscriptionTermsOfServiceURL(termsOfServiceView)
    .subscriptionPrivacyPolicyDestination(privacyPolicyView)
```

This functionality is also supported by the UIKit wrapper. You can use ``SubscriptionsViewController/subscriptionTermsOfServiceURL`` or ``SubscriptionsViewController/subscriptionPrivacyPolicyURL`` to pass URLs to webpages, or ``SubscriptionsViewController/subscriptionTermsOfServiceView`` or ``SubscriptionsViewController/subscriptionPrivacyPolicyView`` to provide custom views.

```swift
// UIKit

let subscriptionsVC = SubscriptionsViewController(ids: ["com.company.subscription_id_1", "com.company.subscription_id_2"])

// Custom views

subscriptionsVC.subscriptionPrivacyPolicyView = ... // set a custom privacy policy view
subscriptionsVC.subscriptionTermsOfServiceView = ... // set a custom terms of service view

// Set URLs

subscriptionsVC.subscriptionPrivacyPolicyURL = ... // set a custom privacy policy url
subscriptionsVC.subscriptionTermsOfServiceURL = ... // set a custom terms of service url

let nav = UINavigationController(rootViewController: subscriptionsVC)
present(nav, animated: true)
```

## Active Subscription

Starting from iOS 15.0, macOS 12.0, and tvOS 15.0, Flare can detect active subscriptions under the hood. If you need to support lower OS versions or you want to implement custom logic, you can create an object that conforms to ``ISubscriptionStatusVerifier`` and pass it to the configuration method of FlareUI.

```swift
struct SubscriptionVerifier: ISubscriptionStatusVerifier {
    func validate(_ storeProduct: StoreProduct) async throws -> Bool {
        // Write your logic here
    }
}
```

To configure FlareUI with a custom subscription verifier, pass the verifier using the configuration.

```swift
let subscriptionVerifier = SubscriptionVerifier()
FlareUI.configure(with: UIConfiguration(subscriptionVerifier: subscriptionVerifier))
```
