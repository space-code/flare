//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
import Foundation
import class StoreKit.SKProduct
import XCTest

// MARK: - SKProductTests

final class SKProductTests: XCTestCase {
    func test_thatSKProductFormatsPriceValueAccoringToLocale() {
        // given
        let product = ProductMock()
        product.stubbedPrice = NSDecimalNumber(value: UInt.price)
        product.stubbedPriceLocale = Locale(identifier: .localeID)

        // when
        let localizedPrice = product.localizedPrice

        // then
        XCTAssertEqual(localizedPrice, "$100.00")
    }
}

// MARK: - Constants

private extension UInt {
    static let price = 100
}

private extension String {
    static let localeID = "en_US"
}
