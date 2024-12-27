//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif
import StoreKit

// MARK: - RefundProvider

final class RefundProvider {
    // MARK: Properties

    private let systemInfoProvider: ISystemInfoProvider
    private let refundRequestProvider: IRefundRequestProvider

    // MARK: Initialization

    init(
        systemInfoProvider: ISystemInfoProvider = SystemInfoProvider(),
        refundRequestProvider: IRefundRequestProvider = RefundRequestProvider()
    ) {
        self.systemInfoProvider = systemInfoProvider
        self.refundRequestProvider = refundRequestProvider
    }

    // MARK: Private

    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        private func initRefundRequest(
            transactionID: UInt64,
            windowScene: UIWindowScene
        ) async throws -> RefundRequestStatus {
            let status = try await refundRequestProvider.beginRefundRequest(
                transactionID: transactionID,
                windowScene: windowScene
            )
            return mapStatus(status)
        }

        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        private func mapStatus(_ status: Result<StoreKit.Transaction.RefundRequestStatus, Error>) -> RefundRequestStatus {
            switch status {
            case let .success(status):
                switch status {
                case .success:
                    return .success
                case .userCancelled:
                    return .userCancelled
                @unknown default:
                    return .unknown
                }
            case let .failure(error):
                return .failed(error: error)
            }
        }
    #endif
}

// MARK: IRefundProvider

extension RefundProvider: IRefundProvider {
    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        func beginRefundRequest(productID: String) async throws -> RefundRequestStatus {
            let windowScene = try await systemInfoProvider.currentScene
            let transactionID = try await refundRequestProvider.verifyTransaction(productID: productID)
            return try await initRefundRequest(transactionID: transactionID, windowScene: windowScene)
        }
    #endif
}
