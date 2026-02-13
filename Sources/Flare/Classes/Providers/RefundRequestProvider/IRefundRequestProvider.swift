//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation
import StoreKit

#if canImport(UIKit)
    import UIKit
#endif

// MARK: - IRefundRequestProvider

/// A type can create a refund request.
protocol IRefundRequestProvider {
    // Present the refund request sheet for the specified transaction in a window scene.
    //
    // - Parameters:
    //   - transactionID: The identifier of the transaction the user is requesting a refund for.
    //   - windowScene: The UIWindowScene that the system displays the sheet on.
    //
    // - Returns: The result of the refund request.
    #if os(iOS) || VISION_OS
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        func beginRefundRequest(
            transactionID: UInt64,
            windowScene: UIWindowScene
        ) async throws -> Result<StoreKit.Transaction.RefundRequestStatus, Error>

        /// Verifies the latest user's transaction.
        ///
        /// - Parameter productID: The product identifier.
        ///
        /// - Returns: The identifier of the transaction.
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        func verifyTransaction(productID: String) async throws -> UInt64
    #endif
}
