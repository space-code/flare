//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ISubscriptionsPresenter

protocol ISubscriptionsPresenter {
    func viewDidLoad()
}

// MARK: - SubscriptionsPresenter

final class SubscriptionsPresenter {
    // MARK: Properties

    private let iap: IFlare
    private let type: SubscptionType

    // MARK: Initialization

    init(iap: IFlare, type: SubscptionType) {
        self.iap = iap
        self.type = type
    }
}

// MARK: ISubscriptionsPresenter

extension SubscriptionsPresenter: ISubscriptionsPresenter {
    func viewDidLoad() {}
}
