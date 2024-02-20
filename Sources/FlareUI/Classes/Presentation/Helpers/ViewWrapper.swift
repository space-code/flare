//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IViewWrapper

protocol IViewWrapper: View {
    associatedtype ViewModel

    init(viewModel: ViewModel)
}

// MARK: - ViewWrapper

struct ViewWrapper<ViewModel, ViewWrapper: IViewWrapper>: IViewWrapper where ViewWrapper.ViewModel == ViewModel {
    // MARK: Properties

    @ObservedObject private var viewModel: FlareUI.ViewModel<ViewModel>

    // MARK: Initialization

    init(viewModel: FlareUI.ViewModel<ViewModel>) {
        self.viewModel = viewModel
    }

    // MARK: IViewWrapper

    var body: some View {
        ViewWrapper(viewModel: viewModel.model)
    }
}
