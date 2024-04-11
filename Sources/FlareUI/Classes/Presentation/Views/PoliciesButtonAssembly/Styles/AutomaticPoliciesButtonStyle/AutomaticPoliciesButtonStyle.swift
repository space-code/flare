//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct AutomaticPoliciesButtonStyle: IPoliciesButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(tvOS)
            return TVPoliciesButtonStyle().makeBody(configuration: configuration)
        #else
            return DefaultPoliciesButtonStyle().makeBody(configuration: configuration)
        #endif
    }
}
