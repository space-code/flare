//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - PoliciesButtonView

struct PoliciesButtonView: View {
    // MARK: Types

    private enum LinkType {
        case termsOfService
        case privacyPolicy
    }

    // MARK: Private

//    @State private var isPresented = false
    @State private var link: LinkType?
    private var isPresented: Binding<Bool> {
        Binding { link != nil } set: { _ in link = nil }
    }

    @Environment(\.subscriptionTermsOfServiceURL) private var subscriptionTermsOfServiceURL
    @Environment(\.subscriptionPrivacyPolicyURL) private var subscriptionPrivacyPolicyURL
    @Environment(\.subscriptionTermsOfServiceDestination) private var subscriptionTermsOfServiceDestination
    @Environment(\.subscriptionPrivacyPolicyDestination) private var subscriptionPrivacyPolicyDestination

    @Environment(\.tintColor) private var tintColor

    // MARK: View

    var body: some View {
        HStack(spacing: .spacing) {
            Button(action: {
                link = .termsOfService
            }, label: {
                Text(L10n.Common.termsOfService)
                    .foregroundColor(tintColor)
            })
            Text(L10n.Common.Words.and)
            Button(action: {
                link = .privacyPolicy
            }, label: {
                Text(L10n.Common.privacyPolicy)
                    .foregroundColor(tintColor)
            })
        }
        .font(.footnote)
        .sheet(isPresented: isPresented) {
            contentView
        }
    }

    private var contentView: some View {
        link.map { link in
            Group {
                switch link {
                case .privacyPolicy:
                    privacyPolicyContentView
                case .termsOfService:
                    privacyTermsOfServiceView
                }
            }
        }
    }

    @ViewBuilder
    private var privacyPolicyContentView: some View {
        if subscriptionPrivacyPolicyDestination != nil {
            subscriptionPrivacyPolicyDestination
        } else if let subscriptionPrivacyPolicyURL {
            safariView(subscriptionPrivacyPolicyURL)
        } else {
            PoliciesUnavailableView(type: .privacyPolicy)
        }
    }

    @ViewBuilder
    private var privacyTermsOfServiceView: some View {
        if subscriptionTermsOfServiceDestination != nil {
            subscriptionTermsOfServiceDestination
        } else if let subscriptionTermsOfServiceURL {
            safariView(subscriptionTermsOfServiceURL)
        } else {
            PoliciesUnavailableView(type: .termsOfService)
        }
    }

    private func safariView(_ url: URL) -> some View {
        SafariWebView(url: url).edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Constants

private extension CGFloat {
    static let spacing = 3.0
}

#if swift(>=5.9)
    #Preview {
        PoliciesButtonView()
    }
#endif
