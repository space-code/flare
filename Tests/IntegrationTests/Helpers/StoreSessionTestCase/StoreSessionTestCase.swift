//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import StoreKitTest
import XCTest

// MARK: - StoreSessionTestCase

@available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
class StoreSessionTestCase: XCTestCase {
    // MARK: Properties

    var session: SKTestSession?

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()

        session = try? SKTestSession(configurationFileNamed: "Flare")
        session?.resetToDefaultState()
        session?.askToBuyEnabled = false
        session?.disableDialogs = true
    }

    override func tearDown() {
        session?.clearTransactions()
        session = nil
        super.tearDown()
    }
}

@available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *)
extension StoreSessionTestCase {
    func expireSubscription(product: StoreProduct) {
        do {
            try session?.expireSubscription(productIdentifier: product.productIdentifier)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    @available(iOS 15.2, tvOS 15.2, macOS 12.1, watchOS 8.3, *)
    func findTransaction(for productID: String) async throws -> Transaction {
        let transactions: [Transaction] = await Transaction.currentEntitlements
            .compactMap { result in
                switch result {
                case let .verified(transaction):
                    transaction
                case .unverified:
                    nil
                }
            }
            .filter { (transaction: Transaction) in
                transaction.productID == productID
            }
            .extractValues()

        return try XCTUnwrap(transactions.first)
    }

    @available(iOS 15.2, tvOS 15.2, macOS 12.1, watchOS 8.3, *)
    func latestTransaction(for productID: String) async throws -> Transaction {
        let result: Transaction? = await Transaction.latest(for: productID)
            .flatMap { result -> Transaction? in
                switch result {
                case let .verified(transaction):
                    return transaction
                case .unverified:
                    return nil
                }
            }

        return try XCTUnwrap(result)
    }

    func clearTransactions() {
        session?.clearTransactions()
    }

    func forceRenewalOfSubscription(for productIdentifier: String) throws {
        try session?.forceRenewalOfSubscription(productIdentifier: productIdentifier)
    }
}
