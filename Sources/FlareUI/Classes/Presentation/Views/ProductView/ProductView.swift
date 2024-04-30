//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

/// A view for displaying a product.
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
