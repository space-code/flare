//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct PoliciesButtonStyleConfiguration: Sendable {
    // MARK: Types

    struct ButtonView: View {
        var body: AnyView

        init(_ view: some View) {
            body = view.eraseToAnyView()
        }
    }

    // MARK: Properties

    let termsOfUseView: ButtonView
    let privacyPolicyView: ButtonView
}
