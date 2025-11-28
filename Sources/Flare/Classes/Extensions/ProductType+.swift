//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
extension ProductType {
    init(_ type: StoreKit.Product.ProductType) {
        switch type {
        case .consumable:
            self = .consumable
        case .nonConsumable:
            self = .nonConsumable
        case .nonRenewable:
            self = .nonRenewableSubscription
        case .autoRenewable:
            self = .autoRenewableSubscription
        default:
            self = .nonConsumable
        }
    }
}

extension ProductType {
    var productCategory: ProductCategory {
        switch self {
        case .consumable:
            .nonSubscription
        case .nonConsumable:
            .nonSubscription
        case .nonRenewableSubscription:
            .subscription
        case .autoRenewableSubscription:
            .subscription
        }
    }
}
