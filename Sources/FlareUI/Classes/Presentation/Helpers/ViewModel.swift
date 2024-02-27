//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// An observable view model.
final class ViewModel<T>: ObservableObject {
    // MARK: Properties

    /// The model object.
    @Published var model: T

    // MARK: Initialization

    /// Creates a `ViewModel` instance.
    ///
    /// - Parameter model: The model object.
    init(model: T) {
        self.model = model
    }
}
