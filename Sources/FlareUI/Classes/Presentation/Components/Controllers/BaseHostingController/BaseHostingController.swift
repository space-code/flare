//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if os(iOS) || os(macOS)
    import SwiftUI

    @available(watchOS, unavailable)
    class BaseHostingController<View: SwiftUI.View>: HostingController<View> {
        // MARK: Initialization

        override init?(coder aDecoder: NSCoder, rootView: View) {
            super.init(coder: aDecoder, rootView: rootView)
            setupUI()
        }

        override init(rootView: View) {
            super.init(rootView: rootView)
            setupUI()
        }

        @MainActor dynamic required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupUI()
        }

        // MARK: Private

        private func setupUI() {
            #if os(iOS) || os(tvOS)
                self.view.backgroundColor = .clear
            #elseif os(macOS)
                self.view.wantsLayer = true
                self.view.layer?.backgroundColor = .clear
            #endif
        }
    }
#endif
