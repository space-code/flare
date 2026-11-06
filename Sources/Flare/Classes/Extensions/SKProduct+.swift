//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import StoreKit

extension SKProduct {
    public var localizedPrice: String? {
        formatter.string(from: price)
    }

    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        formatter.currencySymbol = priceLocale.currencySymbol
        return formatter
    }
}
