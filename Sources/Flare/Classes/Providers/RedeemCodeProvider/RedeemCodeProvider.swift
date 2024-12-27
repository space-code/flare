//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - RedeemCodeProvider

/// A final class responsible for providing functionality related to redeeming offer codes.
final class RedeemCodeProvider {
    // MARK: Properties

    /// An instance of a system information provider conforming to the `ISystemInfoProvider`
    private let systemInfoProvider: ISystemInfoProvider

    // MARK: Initialization

    /// Initializes a `RedeemCodeProvider` instance with an optional system information provider.
    ///
    /// - Parameter systemInfoProvider: An instance of a system information provider.
    ///                                 Defaults to a new instance of `SystemInfoProvider` if not provided.
    init(systemInfoProvider: ISystemInfoProvider = SystemInfoProvider()) {
        self.systemInfoProvider = systemInfoProvider
    }
}

// MARK: IRedeemCodeProvider

extension RedeemCodeProvider: IRedeemCodeProvider {
    #if os(iOS) || VISION_OS
        @available(iOS 16.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        func presentOfferCodeRedeemSheet() async throws {
            let windowScene = try await systemInfoProvider.currentScene
            do {
                Logger.debug(message: L10n.Redeem.presentingOfferCodeRedeemSheet)
                try await AppStore.presentOfferCodeRedeemSheet(in: windowScene)
            } catch {
                Logger.error(message: L10n.Redeem.unableToPresentOfferCodeRedeemSheet(error.localizedDescription))
                throw error
            }
        }
    #endif
}
