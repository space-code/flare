//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public struct Configuration {
    // MARK: Properties

    // swiftlint:disable:next line_length
    // https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/implementing_promotional_offers_in_your_app

    /// A string that associates the transaction with a user account on your service.
    ///
    /// - Important: You must set `applicationUsername` to be the same as the one used to generate the signature.
    public let applicationUsername: String

    // MARK: Initialization

    /// Creates a `Configuration` instance.
    ///
    /// - Parameter applicationUsername: A string that associates the transaction with a user account on your service.
    public init(applicationUsername: String) {
        self.applicationUsername = applicationUsername
    }
}
