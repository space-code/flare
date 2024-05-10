//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
@available(watchOS, unavailable)
public extension ISubscriptionControlStyle where Self == ButtonSubscriptionStoreControlStyle {
    static var button: ButtonSubscriptionStoreControlStyle {
        ButtonSubscriptionStoreControlStyle()
    }
}
