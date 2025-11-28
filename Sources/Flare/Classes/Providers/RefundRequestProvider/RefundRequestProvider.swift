//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif
import StoreKit

// MARK: - RefundRequestProvider

final class RefundRequestProvider {}

// MARK: IRefundRequestProvider

extension RefundRequestProvider: IRefundRequestProvider {
    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        func beginRefundRequest(
            transactionID: UInt64,
            windowScene: UIWindowScene
        ) async throws -> Result<StoreKit.Transaction.RefundRequestStatus, Error> {
            do {
                let status = try await StoreKit.Transaction.beginRefundRequest(for: transactionID, in: windowScene)
                return .success(status)
            } catch {
                return .failure(mapError(error))
            }
        }

        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func verifyTransaction(productID: String) async throws -> UInt64 {
            guard let state = await StoreKit.Transaction.latest(for: productID) else {
                Logger.error(message: L10n.Purchase.transactionNotFound(productID))
                throw IAPError.transactionNotFound(productID: productID)
            }

            switch state {
            case let .verified(transaction):
                return transaction.id
            case let .unverified(_, result):
                Logger.error(message: L10n.Purchase.transactionUnverified(productID, result.localizedDescription))
                throw result
            }
        }

        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        private func mapError(_ error: Error) -> IAPError {
            if let skError = error as? StoreKit.Transaction.RefundRequestError {
                switch skError {
                case .duplicateRequest:
                    Logger.error(message: L10n.Refund.duplicateRefundRequest(skError.localizedDescription))
                    return .refund(error: .duplicateRequest)
                case .failed:
                    Logger.error(message: L10n.Refund.failedRefundRequest(skError.localizedDescription))
                    return .refund(error: .failed)
                @unknown default:
                    return .unknown
                }
            }
            return .unknown
        }
    #endif
}
