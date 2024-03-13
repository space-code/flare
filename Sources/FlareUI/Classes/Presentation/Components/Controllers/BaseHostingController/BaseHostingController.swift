//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

class BaseHostingController<View: SwiftUI.View>: UIHostingController<View> {
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
        self.view.backgroundColor = .clear
    }
}
