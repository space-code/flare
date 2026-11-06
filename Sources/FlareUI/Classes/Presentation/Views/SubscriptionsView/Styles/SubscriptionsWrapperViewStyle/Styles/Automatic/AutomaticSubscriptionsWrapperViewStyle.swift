//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(watchOS, unavailable)
struct AutomaticSubscriptionsWrapperViewStyle: ISubscriptionsWrapperViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS) || os(macOS)
            FullSubscriptionsWrapperViewStyle().makeBody(configuration: configuration)
        #else
            CompactSubscriptionWrapperViewStyle().makeBody(configuration: configuration)
        #endif
    }
}
