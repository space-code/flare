//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol TransactionListenerDelegate: AnyObject, Sendable {
    func transactionListener(
        _ transactionListener: ITransactionListener,
        transactionDidUpdate result: Result<StoreTransaction, IAPError>
    )
}
