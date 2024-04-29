//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - DefaultPoliciesButtonStyleView

struct DefaultPoliciesButtonStyleView: View {
    // MARK: Properties

    private let configuration: PoliciesButtonStyleConfiguration

    @Environment(\.tintColor) private var tintColor

    // MARK: Initialization

    init(configuration: PoliciesButtonStyleConfiguration) {
        self.configuration = configuration
    }

    // MARK: View

    var body: some View {
        HStack(spacing: .spacing) {
            configuration.termsOfUseView
                .foregroundColor(tintColor)

            Text(L10n.Common.Words.and)

            configuration.privacyPolicyView
                .foregroundColor(tintColor)
        }
    }
}

// MARK: - Constants

private extension CGFloat {
    static let spacing = 3.0
}
