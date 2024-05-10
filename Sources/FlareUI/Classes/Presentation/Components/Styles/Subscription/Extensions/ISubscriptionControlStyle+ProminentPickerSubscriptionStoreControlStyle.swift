//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
public extension ISubscriptionControlStyle where Self == ProminentPickerSubscriptionStoreControlStyle {
    static var prominentPicker: ProminentPickerSubscriptionStoreControlStyle {
        ProminentPickerSubscriptionStoreControlStyle()
    }
}
