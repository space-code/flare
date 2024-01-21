//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - TransactionListener

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
actor TransactionListener {
    // MARK: Types

    typealias TransactionResult = StoreKit.VerificationResult<StoreKit.Transaction>

    // MARK: Private

    private let updates: AsyncStream<TransactionResult>
    private var task: Task<Void, Never>?

    // MARK: Initialization

    init<S: AsyncSequence>(updates: S) where S.Element == TransactionResult {
        self.updates = updates.toAsyncStream()
    }

    // MARK: Private

    private func handle(
        transactionResult: TransactionResult,
        fromTransactionUpdate _: Bool
    ) async throws -> StoreTransaction {
        switch transactionResult {
        case let .verified(transaction):
            return StoreTransaction(
                transaction: transaction,
                jwtRepresentation: transactionResult.jwsRepresentation
            )
        case let .unverified(transaction, verificationError):
            Logger.info(
                message: L10n.Purchase.transactionUnverified(
                    transaction.productID,
                    verificationError.localizedDescription
                )
            )

            throw IAPError.verification(
                error: .unverified(productID: transaction.productID, error: verificationError)
            )
        }
    }
}

// MARK: ITransactionListener

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension TransactionListener: ITransactionListener {
    func listenForTransaction() async {
        task?.cancel()
        task = Task(priority: .utility) { [weak self] in
            guard let self = self else { return }

            for await update in self.updates {
                Task.detached {
                    do {
                        _ = try await self.handle(transactionResult: update, fromTransactionUpdate: true)
                    } catch {
                        Logger.error(message: L10n.Purchase.errorUpdatingTransaction(error.localizedDescription))
                    }
                }
            }
        }
    }

    func handle(purchaseResult: Product.PurchaseResult) async throws -> StoreTransaction? {
        switch purchaseResult {
        case let .success(verificationResult):
            return try await handle(transactionResult: verificationResult, fromTransactionUpdate: false)
        case .userCancelled:
            throw IAPError.paymentCancelled
        case .pending:
            throw IAPError.paymentDefferred
        @unknown default:
            throw IAPError.unknown
        }
    }
}
