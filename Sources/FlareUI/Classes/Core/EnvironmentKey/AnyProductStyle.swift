//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct AnyProductStyle: IProductStyle, @unchecked Sendable {
    // MARK: Properties

    /// A private property to hold the closure that creates the body of the view
    private var _makeBody: (Configuration) -> AnyView

    // MARK: Initialization

    /// Initializes the `AnyProductStyle` with a specific style conforming to `IProductStyle`.
    ///
    /// - Parameter style: A product style.
    init(style: some IProductStyle) {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    // MARK: IProductStyle

    /// Implements the makeBody method required by `IProductStyle`.
    func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}
