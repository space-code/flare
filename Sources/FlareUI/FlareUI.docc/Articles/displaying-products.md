# Displaying Products

Learn how to display a set of products to a user.

## Overview

The `FlareUI` provides an easy way to display different kinds of products with a single line of code. To display a set of products to the user, just pass a collection of identifiers to the ``ProductsView``.

```swift
ProductsView(ids: ["com.company.product_id_1", "com.company.product_id_2"])
```

Once `ProductsView` fetches these products from the App Store, it will display them to the user. If the products can't be fetched for any reason, the `ProductsView` shows a message to the user that the App Store is not available.

> important: By default, all Flare views use cached data if available; otherwise, they fetch the data. If you want to change this behavior, please read more about Flare configuration [here](link).

## UIKit

The `FlareUI` package provides wrappers for the UIKit views. It can be easily integrated into UIKit environments using ``ProductsViewController``.

```swift
let productsVC = ProductsViewController(ids: ["com.company.product_id_1", "com.company.product_id_2"])
let nav = UINavigationController(rootViewController: productsVC)
present(nav, animated: true)
```

The `ProductsViewController` is backed by `ProductsView`, and its behavior is the same.

## Customization

The appearance of the displayed products can be customized using ``SwiftUI/View/productViewStyle(_:)``. There are predefined styles for different platforms: ``LargeProductStyle``, ``CompactProductStyle``.

You can also create your own style. For this, please, read [How to Create a Custom Product Style](<doc:creating-custom-product-style>).

## Custom Buttons

If you have restorable products, the `ProductsView` can show a restore button to the customer. For this, you can use ``SwiftUI/View/storeButton(_:types:)-4x8yd`` or ``ProductsViewController/storeButton(_:types:)``.

```swift
// SwiftUI

ProductsView(ids: ["com.company.product_id_1", "com.company.product_id_2"])
    .storeButton(.visible, types: .restore)
```

```swift
// UIKit

let productsVC = ProductsViewController(ids: ["com.company.product_id_1", "com.company.product_id_2"])
productsVC.storeButton(.visible, types: [.restore])
```

## Topics

### Articles

- <doc:creating-custom-product-style>
- <doc:handling-transactions>
