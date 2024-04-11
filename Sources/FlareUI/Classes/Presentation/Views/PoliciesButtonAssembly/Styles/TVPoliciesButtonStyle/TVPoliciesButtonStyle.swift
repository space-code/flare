//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - TVPoliciesButtonStyle

@available(tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(iOS, unavailable)
struct TVPoliciesButtonStyle: IPoliciesButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .spacing) {
            configuration.termsOfUseView
            configuration.privacyPolicyView
        }
    }
}

// MARK: - Constants

private extension CGFloat {
    static let spacing = 60.0
}
