//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

public struct ProductStyleConfiguration {
    public enum State {
        case loading
        case product(item: StoreProduct)
        case error(error: IAPError)
    }

    public struct Icon: View {
        public init<Content: View>(content: Content) {
            body = AnyView(content)
        }

        public var body: AnyView
    }

    public let icon: Icon?
    public let state: State
    public let purchase: () -> Void

    public init(icon: Icon? = nil, state: State, purchase: @escaping () -> Void = {}) {
        self.icon = icon
        self.state = state
        self.purchase = purchase
    }
}
