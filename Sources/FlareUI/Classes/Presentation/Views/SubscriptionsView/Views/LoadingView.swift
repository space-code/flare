//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        loadingView
    }

    private var loadingView: some View {
        VStack(alignment: .center, spacing: 52) {
            if #available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *) {
                progressView
                    .scaleEffect(1.74)
            } else if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *) {
                #if os(tvOS)
                    progressView
                #else
                    progressView
                        .controlSize(.large)
                #endif
            } else {
                ActivityIndicatorView(isAnimating: .constant(true), style: .large)
            }

            Text(L10n.Subscription.Loading.message)
                .font(.subheadline)
                .foregroundColor(Palette.systemGray)
        }
    }

    @available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
    private var progressView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}
