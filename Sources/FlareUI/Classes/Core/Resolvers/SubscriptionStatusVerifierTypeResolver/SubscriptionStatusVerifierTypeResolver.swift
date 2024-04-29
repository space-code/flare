//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

final class SubscriptionStatusVerifierTypeResolver: ISubscriptionStatusVerifierTypeResolver {
    // MARK: ISubscriptionStatusVerifierTypeResolver

    func resolve(_ type: SubscriptionStatusVerifierType) -> (any ISubscriptionStatusVerifier)? {
        switch type {
        case .automatic:
            if #available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *) {
                return SubscriptionStatusVerifier()
            }
            return nil
        case let .custom(subscriptionVerifier):
            return subscriptionVerifier
        }
    }
}
