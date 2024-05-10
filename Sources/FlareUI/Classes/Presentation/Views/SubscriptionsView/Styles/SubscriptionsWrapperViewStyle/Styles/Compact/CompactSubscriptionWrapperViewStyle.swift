//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(tvOS 13.0, *)
@available(macOS, unavailable)
@available(iOS, unavailable)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
struct CompactSubscriptionWrapperViewStyle: ISubscriptionsWrapperViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        CompactSubscriptionWrapperView(configuration: configuration)
    }
}
