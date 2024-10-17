//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

final class IAPErrorTests: XCTestCase {
    func test_thatIAPErrorInstantiatesANewInstanceFromSkError_whenCodeIsEqualToPaymentNotAllowed() {
        // given
        let skError = SKError(SKError.Code.paymentNotAllowed)

        // when
        let error = IAPError(error: skError)

        // then
        XCTAssertEqual(error, IAPError.paymentNotAllowed)
    }

    func test_thatIAPErrorInstantiatesANewInstanceFromSkError_whenCodeIsEqualToPaymentCancelled() {
        // given
        let skError = SKError(SKError.Code.paymentCancelled)

        // when
        let error = IAPError(error: skError)

        // then
        XCTAssertEqual(error, IAPError.paymentCancelled)
    }

    func test_thatIAPErrorInstantiatesANewInstanceFromSkError_whenCodeIsEqualToStoreProductNotAvailable() {
        // given
        let skError = SKError(SKError.Code.storeProductNotAvailable)

        // when
        let error = IAPError(error: skError)

        // then
        XCTAssertEqual(error, IAPError.storeProductNotAvailable)
    }

    func test_thatIAPErrorInstantiatesANewInstanceFromSkError_whenErrorIsNil() {
        // when
        let error = IAPError(error: nil)

        // then
        XCTAssertEqual(error, IAPError.unknown)
    }
}
