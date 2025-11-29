//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - PoliciesUnavailableView

struct PoliciesUnavailableView: View {
    // MARK: Types

    enum PolicyType {
        case privacyPolicy
        case termsOfService

        var title: String {
            switch self {
            case .privacyPolicy:
                L10n.Policies.Unavailable.PrivacyPolicy.title
            case .termsOfService:
                L10n.Policies.Unavailable.TermsOfService.title
            }
        }

        var message: String {
            switch self {
            case .privacyPolicy:
                L10n.Policies.Unavailable.PrivacyPolicy.message
            case .termsOfService:
                L10n.Policies.Unavailable.TermsOfService.message
            }
        }
    }

    // MARK: Properties

    private let type: PolicyType

    // MARK: Initialization

    init(type: PolicyType) {
        self.type = type
    }

    // MARK: View

    var body: some View {
        VStack {
            Text(type.title)
                .font(.title)
                .multilineTextAlignment(.center)
            Text(type.message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Palette.systemGray)
        }
        .padding()
    }
}

#if swift(>=5.9)
    #Preview {
        StoreUnavaliableView(productType: .product)
    }
#endif
