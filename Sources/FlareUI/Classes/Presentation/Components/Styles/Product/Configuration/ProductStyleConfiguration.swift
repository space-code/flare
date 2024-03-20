//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

/// Configuration for the style of a product, including its state and purchase action.
public struct ProductStyleConfiguration {
    // MARK: Types

    /// Represents the state of the product style.
    public enum State {
        /// The product is currently loading.
        case loading
        /// The product is available for purchase, with the specified store product item.
        case product(item: StoreProduct)
        /// An error occurred while loading the product.
        case error(error: IAPError)
    }

    /// Represents the icon view for the product.
    public struct Icon: View {
        // MARK: Properties

        /// The body of the icon view.
        public var body: AnyView

        // MARK: Initialization

        /// Initializes the icon view with the specified content.
        ///
        /// - Parameter content: The content of the icon view.
        public init<Content: View>(content: Content) {
            body = AnyView(content)
        }
    }

    // MARK: Properties

    /// The icon view for the product.
    public let icon: Icon?
    /// The state of the product.
    public let state: State
    /// The purchase action.
    public let purchase: () -> Void

    // MARK: Initialization

    /// Initializes the product style configuration with the specified parameters.
    ///
    /// - Parameters:
    ///   - icon: The icon view for the product.
    ///   - state: The state of the product.
    ///   - purchase: The purchase action.
    public init(icon: Icon? = nil, state: State, purchase: @escaping () -> Void = {}) {
        self.icon = icon
        self.state = state
        self.purchase = purchase
    }
}
