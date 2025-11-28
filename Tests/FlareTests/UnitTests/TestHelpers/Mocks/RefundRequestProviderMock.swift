//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if os(iOS) || VISION_OS
    @testable import Flare
    import StoreKit
    import UIKit

    @available(iOS 15.0, macCatalyst 15.0, *)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    final class RefundRequestProviderMock: IRefundRequestProvider {
        var invokedBeginRefundRequest = false
        var invokedBeginRefundRequestCount = 0
        var invokedBeginRefundRequestParameters: (transactionID: UInt64, windowScene: UIWindowScene)?
        var invokedBeginRefundRequestParametersList = [(transactionID: UInt64, windowScene: UIWindowScene)]()
        var stubbedBeginRefundRequest: Result<RefundRequestStatus, Error>!

        func beginRefundRequest(
            transactionID: UInt64,
            windowScene: UIWindowScene
        ) async throws -> Result<StoreKit.Transaction.RefundRequestStatus, Error> {
            invokedBeginRefundRequest = true
            invokedBeginRefundRequestCount += 1
            invokedBeginRefundRequestParameters = (transactionID, windowScene)
            invokedBeginRefundRequestParametersList.append((transactionID, windowScene))

            switch stubbedBeginRefundRequest {
            case let .success(status):
                return .success(mapToSkStatus(status))
            case let .failure(error):
                return .failure(error)
            case .none:
                fatalError()
            }
        }

        var invokedVerifyTransaction = false
        var invokedVerifyTransactionCount = 0
        var invokedVerifyTransactionParameters: (productID: String, Void)?
        var invokedVerifyTransactionParametersList = [(productID: String, Void)]()
        var stubbedVerifyTransaction: UInt64!

        func verifyTransaction(productID: String) async throws -> UInt64 {
            invokedVerifyTransaction = true
            invokedVerifyTransactionCount += 1
            invokedVerifyTransactionParameters = (productID, ())
            invokedVerifyTransactionParametersList.append((productID, ()))
            return stubbedVerifyTransaction
        }

        // MARK: Private

        private func mapToSkStatus(_ status: RefundRequestStatus) -> StoreKit.Transaction.RefundRequestStatus {
            switch status {
            case .success:
                return .success
            case .userCancelled:
                return .userCancelled
            default:
                fatalError()
            }
        }
    }
#endif
