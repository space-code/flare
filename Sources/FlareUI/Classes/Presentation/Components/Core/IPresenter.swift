//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IPresenter

protocol IPresenter {
    associatedtype Model: IModel

    var viewModel: ViewModel<Model>? { get }

    func update(state: Model.State, animation: Animation?)
}

extension IPresenter {
    func update(state: Model.State, animation: Animation? = .default) {
        guard let viewModel else { return }
        withAnimation(animation) {
            viewModel.model = viewModel.model.setState(state)
        }
    }
}
