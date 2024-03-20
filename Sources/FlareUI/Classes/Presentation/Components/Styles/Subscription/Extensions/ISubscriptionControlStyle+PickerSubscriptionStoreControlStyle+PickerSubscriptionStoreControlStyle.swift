//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

@available(iOS 13.0, macOS 10.15, watchOS 7.0, *)
@available(tvOS, unavailable)
public extension ISubscriptionControlStyle where Self == PickerSubscriptionStoreControlStyle {
    static var picker: PickerSubscriptionStoreControlStyle {
        PickerSubscriptionStoreControlStyle()
    }
}
