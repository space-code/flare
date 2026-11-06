//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

/// A type that can refund purchases.
protocol IRefundProvider {
    #if os(iOS) || VISION_OS
        /// Present the refund request sheet for the specified transaction in a window scene.
        ///
        /// - Parameter productID: The identifier of the transaction the user is requesting a refund for.
        ///
        /// - Returns: The result of the refund request.
        @available(iOS 15.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        func beginRefundRequest(productID: String) async throws -> RefundRequestStatus
    #endif
}
