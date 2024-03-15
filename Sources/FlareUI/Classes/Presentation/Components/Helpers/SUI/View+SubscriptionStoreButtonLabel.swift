//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public extension View {
    func subscriptionPickerItemBackground(_ backgroundStyle: Color) -> some View {
        environment(\.subscriptionPickerItemBackground, backgroundStyle)
    }
}
