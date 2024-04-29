//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct AnyPoliciesButtonStyle: IPoliciesButtonStyle {
    // MARK: Properties

    let style: any IPoliciesButtonStyle

    /// A private property to hold the closure that creates the body of the view
    private var _makeBody: (Configuration) -> AnyView

    // MARK: Initialization

    /// Initializes the `AnyPoliciesButtonStyle` with a specific style conforming to `IPoliciesButtonStyle`.
    ///
    /// - Parameter style: A product style.
    init<S: IPoliciesButtonStyle>(style: S) {
        self.style = style
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    // MARK: IPoliciesButtonStyle

    /// Implements the makeBody method required by `IPoliciesButtonStyle`.
    func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}
