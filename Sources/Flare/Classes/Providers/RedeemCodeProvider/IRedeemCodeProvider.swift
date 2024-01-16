//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// Protocol defining the requirements for a redeem code provider.
protocol IRedeemCodeProvider {
    #if os(iOS) || VISION_OS
        /// Displays a sheet in the window scene that enables users to redeem
        /// a subscription offer code configured in App Store Connect.
        ///
        /// - Important: This method is available starting from iOS 16.0.
        /// - Note: This method is not available on macOS, watchOS, or tvOS.
        ///
        /// - Throws: An error if there is an issue with presenting the redeem code sheet.
        @available(iOS 16.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        func presentOfferCodeRedeemSheet() async throws
    #endif
}
