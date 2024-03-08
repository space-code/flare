//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - StoreUnavaliableView

struct StoreUnavaliableView: View {
    var body: some View {
        VStack {
            Text(L10n.StoreUnavailable.title)
                .font(.title)
            Text(L10n.StoreUnavailable.message)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Palette.systemGray)
        }
        .padding()
    }
}

#if swift(>=5.9)
    #Preview {
        StoreUnavaliableView()
    }
#endif
