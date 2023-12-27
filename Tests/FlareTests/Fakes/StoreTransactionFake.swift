//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare

extension StoreTransaction {
    static func fakeSK1(storeTransaction: IStoreTransaction? = nil) -> StoreTransaction {
        StoreTransaction(storeTransaction: storeTransaction ?? StoreTransactionStub())
    }
}
