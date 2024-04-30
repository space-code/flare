//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view for displaying multiple products.
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
    }
}
