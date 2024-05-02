//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view for displaying a product.
///
/// A `ProductView` shows information about an in-app purchase product, including its localized name, description,
/// and price, and displays a purchase button.
///
/// You create a product view by providing a product identifier to load from the App Store. If you provide a product identifier,
/// the view loads the product’s information from the App Store automatically, and updates the view when the product is available.
///
/// You can customize the product view’s appearance using the standard styles, including the ``LargeProductStyle`` and
/// ``CompactProductStyle`` styles. Apply the style using the ``SwiftUI/View/productViewStyle(_:)``.
///
/// You can also create your own custom styles by creating styles that conform to the ``IProductStyle`` protocol.
///
/// ## Example ##
///
/// ```swift
/// struct AppProductView: View {
///     var body: some View {
///         ProductView(id: "com.company.app.product_id")
///     }
/// }
/// ```
@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public struct ProductView: View {
    // MARK: Properties

    /// The presentation assembly for creating views.
    private let presentationAssembly = PresentationAssembly()

    /// The ID of the product to display.
    private let id: String

    // MARK: Initialization

    /// Initializes the product view with the given ID.
    ///
    /// - Parameter id: The ID of the product to display.
    public init(id: String) {
        self.id = id
    }

    // MARK: View

    public var body: some View {
        presentationAssembly.productViewAssembly.assemble(id: id)
    }
}
