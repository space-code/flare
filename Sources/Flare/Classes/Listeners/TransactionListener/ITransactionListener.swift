//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

protocol ITransactionListener: Sendable {
    func listenForTransaction() async

    @available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
    func handle(purchaseResult: StoreKit.Product.PurchaseResult) async throws -> StoreTransaction?
}
