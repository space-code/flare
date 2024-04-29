//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(watchOS, unavailable)
struct AutomaticSubscriptionsWrapperViewStyle: ISubscriptionsWrapperViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS) || os(macOS)
            return FullSubscriptionsWrapperViewStyle().makeBody(configuration: configuration)
        #else
            return CompactSubscriptionWrapperViewStyle().makeBody(configuration: configuration)
        #endif
    }
}
