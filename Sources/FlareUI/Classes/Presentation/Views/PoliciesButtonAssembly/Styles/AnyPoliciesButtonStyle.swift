//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct AnyPoliciesButtonStyle: IPoliciesButtonStyle {
    // MARK: Properties

    let style: any IPoliciesButtonStyle

    // MARK: Initialization

    /// Initializes the `AnyPoliciesButtonStyle` with a specific style conforming to `IPoliciesButtonStyle`.
    ///
    /// - Parameter style: A product style.
    init(style: some IPoliciesButtonStyle) {
        self.style = style
    }

    // MARK: IPoliciesButtonStyle

    /// Implements the makeBody method required by `IPoliciesButtonStyle`.
    func makeBody(configuration: Configuration) -> some View {
        AnyView(style.makeBody(configuration: configuration))
    }
}
