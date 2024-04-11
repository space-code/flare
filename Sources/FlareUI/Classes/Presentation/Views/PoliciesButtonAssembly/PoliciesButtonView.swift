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

    @State private var link: LinkType?
    private var isPresented: Binding<Bool> {
        Binding { link != nil } set: { _ in link = nil }
    }

    @Environment(\.subscriptionTermsOfServiceURL) private var subscriptionTermsOfServiceURL
    @Environment(\.subscriptionPrivacyPolicyURL) private var subscriptionPrivacyPolicyURL
    @Environment(\.subscriptionTermsOfServiceDestination) private var subscriptionTermsOfServiceDestination
    @Environment(\.subscriptionPrivacyPolicyDestination) private var subscriptionPrivacyPolicyDestination

    @Environment(\.tintColor) private var tintColor
    @Environment(\.policiesButtonStyle) private var policiesButtonStyle

    // MARK: View

    var body: some View {
        policiesButtonStyle.makeBody(
            configuration: .init(
                termsOfUseView: .init(termsOfServiceButton),
                privacyPolicyView: .init(privacyPolicyButton)
            )
        )
        .font(.footnote)
        .sheet(isPresented: isPresented) {
            contentView
        }
    }

    private var termsOfServiceButton: some View {
        Button(action: {
            link = .termsOfService
        }, label: {
            Text(L10n.Common.termsOfService)
        })
    }

    private var privacyPolicyButton: some View {
        Button(action: {
            link = .privacyPolicy
        }, label: {
            Text(L10n.Common.privacyPolicy)
        })
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
            #if os(iOS)
                safariView(subscriptionPrivacyPolicyURL)
            #endif
        } else {
            PoliciesUnavailableView(type: .privacyPolicy)
        }
    }

    @ViewBuilder
    private var privacyTermsOfServiceView: some View {
        if subscriptionTermsOfServiceDestination != nil {
            subscriptionTermsOfServiceDestination
        } else if let subscriptionTermsOfServiceURL {
            #if os(iOS)
                safariView(subscriptionTermsOfServiceURL)
            #endif
        } else {
            PoliciesUnavailableView(type: .termsOfService)
        }
    }

    #if os(iOS)
        @available(iOS 13.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        private func safariView(_ url: URL) -> some View {
            SafariWebView(url: url).edgesIgnoringSafeArea(.all)
        }
    #endif
}

#if swift(>=5.9)
    #Preview {
        PoliciesButtonView()
    }
#endif
