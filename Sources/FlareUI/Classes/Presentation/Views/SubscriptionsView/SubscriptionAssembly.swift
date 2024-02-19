//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

// MARK: - ISubscriptionAssembly

protocol ISubscriptionAssembly {
    func assembly(type: SubscptionType) -> SubscriptionsView
}

// MARK: - SubscriptionAssembly

final class SubscriptionAssembly: ISubscriptionAssembly {
    // MARK: Properties

    private let iap: IFlare

    // MARK: Initialization

    init(iap: IFlare) {
        self.iap = iap
    }

    // MARK: ISubscriptionAssembly

    func assembly(type: SubscptionType) -> SubscriptionsView {
        let presenter = SubscriptionsPresenter(iap: iap, type: type)
        return SubscriptionsView(presenter: presenter)
    }
}
