//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(watchOS, unavailable)
protocol ISubscriptionsWrapperViewStyle {
    /// A view that represents the body of an in-app subscription store control.
    associatedtype Body: View

    /// The properties of an in-app subscription store control.
    typealias Configuration = SubscriptionsWrapperViewStyleConfiguration

    /// Creates a view that represents the body of an in-app subscription store control.
    ///
    /// - Parameter configuration: The properties of an in-app subscription store control.
    @MainActor
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}
