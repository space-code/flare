//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - StoreButtonView

struct StoreButtonView: View, IViewWrapper {
    // MARK: Properties

    private let viewModel: StoreButtonViewModel
    @State private var error: Error?

    // MARK: Initialization

    init(viewModel: StoreButtonViewModel) {
        self.viewModel = viewModel
    }

    // MARK: View

    var body: some View {
        contentView
            .errorAlert($error)
    }

    // MARK: Private

    @ViewBuilder
    private var contentView: some View {
        Button(action: {
            Task {
                do {
                    if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
                        try await viewModel.presenter.restore()
                    }
                } catch {
                    self.error = error
                }
            }
        }, label: {
            Text(viewModel.state.title)
        })
    }
}
