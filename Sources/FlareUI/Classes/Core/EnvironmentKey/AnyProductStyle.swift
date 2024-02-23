//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

public struct AnyProductStyle: IProductStyle {
    private var _makeBody: (Configuration) -> AnyView

    init<S: IProductStyle>(style: S) {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}
