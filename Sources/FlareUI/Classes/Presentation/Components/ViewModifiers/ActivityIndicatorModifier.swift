//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ActivityIndicatorModifier

struct ActivityIndicatorModifier: ViewModifier {
    // MARK: Properties

    private let isLoading: Bool

    // MARK: Initialization

    init(isLoading: Bool) {
        self.isLoading = isLoading
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        if isLoading {
            ZStack(alignment: .center) {
                content
                    .disabled(isLoading)
                    .blur(radius: self.isLoading ? 3 : 0)

                LoadingView(type: .backgrouned, message: "Purchasing the subscription...")
            }
        } else {
            content
        }
    }
}

extension View {
    func activityIndicator(isLoading: Bool) -> some View {
        modifier(ActivityIndicatorModifier(isLoading: isLoading))
    }
}
