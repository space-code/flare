//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(watchOS, unavailable)
struct AutomaticPoliciesButtonStyle: IPoliciesButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(tvOS)
            TVPoliciesButtonStyle().makeBody(configuration: configuration)
        #else
            DefaultPoliciesButtonStyle().makeBody(configuration: configuration)
        #endif
    }
}
