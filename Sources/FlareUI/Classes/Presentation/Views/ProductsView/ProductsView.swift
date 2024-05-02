//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view for displaying multiple products.
///
/// A `ProductsView` display a collection of in-app purchase products, iincluding their localized names,
/// descriptions, prices, and displays a purchase button.
///
/// ## Customize the products view ##
///
/// You can customize the store by displaying additional buttons, and applying styles.
///
/// You can change the product style using ``SwiftUI/View/productViewStyle(_:)``.
///
/// ## Example ##
///
/// ```swift
/// struct PaywallView: View {
///     var body: some View {
///         ProductsView(ids: ["com.company.app.product_id"])
///     }
/// }
/// ```
@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct ProductsView: View {
    // MARK: Properties

    /// The presentation assembly for creating views.
    private let presentationAssembly = PresentationAssembly()

    /// The IDs of the products to display.
    private let ids: any Collection<String>

    // MARK: Initialization

    /// Initializes the products view with the given IDs.
    ///
    /// - Parameter ids: The IDs of the products to display.
    public init(ids: some Collection<String>) {
        self.ids = ids
    }

    // MARK: View

    public var body: some View {
        presentationAssembly.productsViewAssembly.assemble(ids: ids)
            .productViewStyle(.large)
    }
}
