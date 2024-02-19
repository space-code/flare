//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct SubscriptionsView: View {
    // MARK: Propertirs

    private let presenter: ISubscriptionsPresenter

    // MARK: Initialization

    init(presenter: ISubscriptionsPresenter) {
        self.presenter = presenter
    }

    // MARK: View

    var body: some View {
        contentView
            .onAppear { presenter.viewDidLoad() }
    }

    // MARK: Private

    private var contentView: some View {
        Text("View")
    }
}
