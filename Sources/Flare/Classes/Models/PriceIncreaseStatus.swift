//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - PriceIncreaseStatus

public enum PriceIncreaseStatus {
    case noIncreasePending
    case pending
    case agreed
}

extension PriceIncreaseStatus {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ status: Product.SubscriptionInfo.RenewalInfo.PriceIncreaseStatus) {
        switch status {
        case .noIncreasePending:
            self = .noIncreasePending
        case .pending:
            self = .pending
        case .agreed:
            self = .agreed
        }
    }
}
