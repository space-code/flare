//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if os(macOS)
    import SwiftUI

    final class ThemableView<Content: View>: NSHostingView<Content> {
        required init(rootView: Content, appearance: NSAppearance?) {
            super.init(rootView: rootView)
            self.appearance = appearance
        }

        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        @MainActor required init(rootView _: Content) {
            fatalError("init(rootView:) has not been implemented")
        }
    }
#endif
