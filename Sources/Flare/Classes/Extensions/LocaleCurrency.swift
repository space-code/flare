//
//  LocaleCurrency.swift
//  Flare
//
//  Created by M7md  on 16/10/2024.
//

import Foundation

extension Locale {
    var currencyID: String? {
        if #available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *) {
            return self.currency?.identifier
        } else {
            return self.currencyCode
        }
    }
}
