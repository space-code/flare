//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public enum SubscriptionStatusVerifierType {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    case automatic

    case custom(ISubscriptionStatusVerifier)
}
