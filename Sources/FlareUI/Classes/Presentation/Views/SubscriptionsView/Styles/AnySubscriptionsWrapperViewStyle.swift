//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(watchOS, unavailable)
struct AnySubscriptionsWrapperViewStyle: ISubscriptionsWrapperViewStyle, @unchecked Sendable {
    // MARK: Properties

    /// A private property to hold the closure that creates the body of the view
    private var style: any ISubscriptionsWrapperViewStyle

    // MARK: Initialization

    /// Initializes the `AnyProductStyle` with a specific style conforming to `IProductStyle`.
    ///
    /// - Parameter style: A product style.
    init(style: some ISubscriptionsWrapperViewStyle) {
        self.style = style
    }

    // MARK: IProductStyle

    /// Implements the makeBody method required by `IProductStyle`.
    func makeBody(configuration: Configuration) -> some View {
        AnyView(style.makeBody(configuration: configuration))
    }
}
