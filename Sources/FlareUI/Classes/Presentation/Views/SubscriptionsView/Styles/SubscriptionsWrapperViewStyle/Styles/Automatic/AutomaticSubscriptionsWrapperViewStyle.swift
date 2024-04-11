//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct AutomaticSubscriptionsWrapperViewStyle: ISubscriptionsWrapperViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS) || os(macOS) || os(watchOS)
            return FullSubscriptionsWrapperViewStyle().makeBody(configuration: configuration)
        #else
            return CompactSubscriptionWrapperViewStyle().makeBody(configuration: configuration)
        #endif
    }
}
