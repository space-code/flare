//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

public struct ProductStyleConfiguration {
    public enum State {
        case loading
        case product(item: StoreProduct)
    }

    public let state: State
    public let purchase: () -> Void

    public init(state: State, purchase: @escaping () -> Void = {}) {
        self.state = state
        self.purchase = purchase
    }
}
