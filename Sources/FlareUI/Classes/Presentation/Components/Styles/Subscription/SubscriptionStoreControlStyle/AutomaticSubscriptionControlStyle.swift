//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - AutomaticSubscriptionControlStyle

@available(watchOS, unavailable)
struct AutomaticSubscriptionControlStyle: ISubscriptionControlStyle {
    // MARK: ISubscriptionControlStyle

    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
            ProminentPickerSubscriptionStoreControlStyle().makeBody(configuration: configuration)
        #else
            ButtonSubscriptionStoreControlStyle().makeBody(configuration: configuration)
        #endif
    }
}

// MARK: - Extensions

@available(watchOS, unavailable)
extension ISubscriptionControlStyle where Self == AutomaticSubscriptionControlStyle {
    static var automatic: AutomaticSubscriptionControlStyle {
        AutomaticSubscriptionControlStyle()
    }
}
