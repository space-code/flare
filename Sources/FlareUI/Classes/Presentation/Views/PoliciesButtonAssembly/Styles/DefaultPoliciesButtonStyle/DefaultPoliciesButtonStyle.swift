//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
struct DefaultPoliciesButtonStyle: IPoliciesButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        DefaultPoliciesButtonStyleView(configuration: configuration)
    }
}
