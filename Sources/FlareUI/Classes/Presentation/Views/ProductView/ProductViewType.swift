//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

/// An enumeration representing different types of product views.
enum ProductViewType {
    /// A product view initialized with a `StoreProduct`.
    case product(StoreProduct)
    /// A product view initialized with a product ID.
    case productID(String)
}
