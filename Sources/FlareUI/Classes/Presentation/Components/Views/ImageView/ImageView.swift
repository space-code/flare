//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    // MARK: Properties

    private let systemName: String
    private let defaultImage: Image

    // MARK: Initialization

    init(systemName: String, defaultImage: Image) {
        self.systemName = systemName
        self.defaultImage = defaultImage
    }

    // MARK: View

    var body: some View {
        Group {
            if #available(macOS 11.0, iOS 14.0, tvOS 14.0, *) {
                Image(systemName: systemName)
                    .resizable()
            } else {
                defaultImage
                    .resizable()
            }
        }
    }
}
