//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

// MARK: - ISubscriptionPriceViewModelFactory

protocol ISubscriptionPriceViewModelFactory {
    func make(_ product: StoreProduct, format: PriceDisplayFormat) -> String
    func period(from product: StoreProduct) -> String?
}
