//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public protocol ISubscriptionControlStyle {
    /// A view that represents the body of an in-app subscription store control.
    associatedtype Body: View

    /// The properties of an in-app subscription store control.
    typealias Configuration = SubscriptionStoreControlStyleConfiguration

    /// Creates a view that represents the body of an in-app subscription store control.
    ///
    /// - Parameters:
    ///   - configuration: The properties of an in-app subscription store control.
    @MainActor
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}
