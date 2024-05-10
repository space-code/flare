//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKit
import SwiftUI

/// Extension for configuring in-app purchase options within a view.
extension View {
    /// Sets the in-app purchase options for the view.
    ///
    /// - Parameter options: A closure that returns the set of purchase options for a given store product.
    ///
    /// - Returns: A modified view with the specified in-app purchase options.
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    public func inAppPurchaseOptions(_ options: ((StoreProduct) -> Set<Product.PurchaseOption>)?) -> some View {
        environment(\.purchaseOptions) { PurchaseOptions(options: options?($0) ?? []) }
    }

    /// Sets the in-app purchase options for the view.
    ///
    /// - Parameter options: A closure that returns the purchase options for a given store product.
    ///
    /// - Returns: A modified view with the specified in-app purchase options.
    func inAppPurchaseOptions(_ options: ((StoreProduct) -> PurchaseOptions)?) -> some View {
        environment(\.purchaseOptions, options)
    }
}
