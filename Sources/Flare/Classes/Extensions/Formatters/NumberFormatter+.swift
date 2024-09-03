//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static func numberFormatter(with locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter
    }

    func numberFormatter(with currencyCode: String, locale: Locale = .autoupdatingCurrent) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.currencyCode = currencyCode
        return formatter
    }
}
