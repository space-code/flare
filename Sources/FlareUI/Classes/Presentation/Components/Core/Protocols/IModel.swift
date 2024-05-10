//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// A type that represents a default model object.
protocol IModel {
    /// The associated type representing the state of the model.
    associatedtype State

    /// The current state of the model.
    var state: State { get }

    /// Function to set the state of the model and return a new instance with the updated state.
    ///
    /// - Parameter state: The new state to set.
    ///
    /// - Returns: A new instance of the model with the updated state.
    func setState(_ state: State) -> Self
}
