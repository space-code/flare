//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

public extension StoreTransaction {
    static func fake() -> StoreTransaction {
        StoreTransaction(paymentTransaction: PaymentTransaction(PaymentTransactionMock()))
    }
}
