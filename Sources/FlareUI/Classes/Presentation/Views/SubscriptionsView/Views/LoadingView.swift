//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    // MARK: Types

    enum LoadingViewType {
        case `default`
        case backgrouned
    }

    // MARK: Properties

    private let type: LoadingViewType
    private let message: String

    // MARK: Initialization

    init(type: LoadingViewType = .default, message: String) {
        self.type = type
        self.message = message
    }

    // MARK: View

    var body: some View {
        switch type {
        case .default:
            loadingView
        case .backgrouned:
            loadingView
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8.0)
                        .fill(Palette.systemBackground)
                )
        }
    }

    // MARK: Private

    private var loadingView: some View {
        VStack(alignment: .center, spacing: 52) {
            if #available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *) {
                #if os(tvOS)
                    progressView
                #else
                    progressView
                        .controlSize(.large)
                #endif
            } else if #available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *) {
                progressView
                    .scaleEffect(1.74)
            } else {
                #if os(macOS)
                    ActivityIndicatorView(isAnimating: .constant(true))
                #else
                    ActivityIndicatorView(isAnimating: .constant(true), style: .large)
                #endif
            }

            Text(message)
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
