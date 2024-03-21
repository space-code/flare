//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - AutomaticSubscriptionControlStyle

struct AutomaticSubscriptionControlStyle: ISubscriptionControlStyle {
    // MARK: ISubscriptionControlStyle

    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
            return ProminentPickerSubscriptionStoreControlStyle().makeBody(configuration: configuration)
        #else
            return ButtonSubscriptionStoreControlStyle().makeBody(configuration: configuration)
        #endif
    }
}

// MARK: - Extensions

extension ISubscriptionControlStyle where Self == AutomaticSubscriptionControlStyle {
    static var automatic: AutomaticSubscriptionControlStyle {
        AutomaticSubscriptionControlStyle()
    }
}
