//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

final class ViewModel<T>: ObservableObject {
    // MARK: Properties

    @Published var model: T

    // MARK: Initialization

    init(model: T) {
        self.model = model
    }
}
