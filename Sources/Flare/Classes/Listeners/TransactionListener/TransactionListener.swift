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

    private let updates: StoreKit.Transaction.Transactions
    private var task: Task<Void, Never>?

    private weak var delegate: TransactionListenerDelegate?

    // MARK: Initialization

    init(delegate: TransactionListenerDelegate? = nil, updates: StoreKit.Transaction.Transactions) {
        self.delegate = delegate
        self.updates = updates // .toAsyncStream()
    }

    // MARK: Private

    private func handle(
        transactionResult: TransactionResult,
        fromTransactionUpdate: Bool
    ) async throws -> StoreTransaction {
        switch transactionResult {
        case let .verified(transaction):
            let transaction = StoreTransaction(
                transaction: transaction,
                jwtRepresentation: transactionResult.jwsRepresentation
            )

            if fromTransactionUpdate {
                delegate?.transactionListener(self, transactionDidUpdate: .success(transaction))
            }

            return transaction
        case let .unverified(transaction, verificationError):
            Logger.info(
                message: L10n.Purchase.transactionUnverified(
                    transaction.productID,
                    verificationError.localizedDescription
                )
            )

            let error = IAPError.verification(
                error: .init(verificationError)
            )

            if fromTransactionUpdate {
                delegate?.transactionListener(self, transactionDidUpdate: .failure(error))
            }

            throw error
        }
    }
}

// MARK: ITransactionListener

@available(iOS 15.0, tvOS 15.0, macOS 12.0, watchOS 8.0, *)
extension TransactionListener: ITransactionListener {
    func set(delegate: TransactionListenerDelegate) {
        self.delegate = delegate
    }

    func listenForTransaction() async {
        task?.cancel()
        task = Task(priority: .utility) { [weak self] in
            guard let self else { return }

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
