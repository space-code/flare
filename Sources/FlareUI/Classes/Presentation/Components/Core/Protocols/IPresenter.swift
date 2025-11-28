//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - IPresenter

/// A protocol that defines the basic functionality of a presenter.
protocol IPresenter {
    /// The associated type representing the model associated with the presenter.
    associatedtype Model: IModel

    /// The view model associated with the presenter.
    var viewModel: WrapperViewModel<Model>? { get }

    /// Updates the state of the presenter's model.
    ///
    /// - Parameters:
    ///   - state: The new state to update to.
    ///   - animation: The animation to use for the state update.
    func update(state: Model.State, animation: Animation?)
}

extension IPresenter {
    /// Default implementation for updating the presenter's model state.
    ///
    /// - Parameters:
    ///   - state: The new state to update to.
    ///   - animation: The animation to use for the state update.
    func update(state: Model.State, animation: Animation? = .default) {
        guard let viewModel else { return }

        withAnimation(animation) {
            viewModel.model = viewModel.model.setState(state)
        }
    }
}
