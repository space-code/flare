//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct AnySubscriptionControlStyle: ISubscriptionControlStyle {
    // MARK: Properties

    let style: any ISubscriptionControlStyle

    // MARK: Initialization

    /// Initializes the `AnyProductStyle` with a specific style conforming to `IProductStyle`.
    ///
    /// - Parameter style: A product style.
    init(style: some ISubscriptionControlStyle) {
        self.style = style
    }

    // MARK: IProductStyle

    /// Implements the makeBody method required by `IProductStyle`.
    func makeBody(configuration: Configuration) -> some View {
        AnyView(style.makeBody(configuration: configuration))
    }
}
