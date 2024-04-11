//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct PoliciesButtonStyleConfiguration {
    // MARK: Types

    struct ButtonView: View {
        var body: AnyView

        init<Content: View>(_ view: Content) {
            body = view.eraseToAnyView()
        }
    }

    // MARK: Properties

    let termsOfUseView: ButtonView
    let privacyPolicyView: ButtonView
}
