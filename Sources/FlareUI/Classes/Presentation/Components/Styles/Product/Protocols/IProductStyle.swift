//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public protocol IProductStyle {
    /// The properties of an in-app store product.
    typealias Configuration = ProductStyleConfiguration

    /// A view that represents the body of an in-app store product.
    associatedtype Body: View

    /// Creates a view that represents the body of an in-app store product.
    /// - Parameter configuration: The properties of an in-app store product.
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}
