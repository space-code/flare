//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public struct Configuration: Sendable {
    // MARK: Properties

    // swiftlint:disable:next line_length
    // https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/implementing_promotional_offers_in_your_app

    /// A string that associates the transaction with a user account on your service.
    ///
    /// - Important: You must set `applicationUsername` to be the same as the one used to generate the signature.
    public let applicationUsername: String

    /// The cache policy for fetching products.
    public let fetchCachePolicy: FetchCachePolicy

    // MARK: Initialization

    /// Creates a `Configuration` instance.
    ///
    /// - Parameters:
    ///    - applicationUsername: A string that associates the transaction with a user account on your service.
    ///    - fetchCachePolicy: The cache policy for fetching products.
    public init(
        applicationUsername: String,
        fetchCachePolicy: FetchCachePolicy = .cachedOrFetch
    ) {
        self.applicationUsername = applicationUsername
        self.fetchCachePolicy = fetchCachePolicy
    }
}
