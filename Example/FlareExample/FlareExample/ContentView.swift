//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import FlareUI
import SwiftUI

struct ContentView: View {
    @State var isPresented = false

    var body: some View {
        VStack {
            Button("IAP") {
                isPresented.toggle()
            }
        }
        .paywall(
            presented: $isPresented,
            paywallType: .products(productIDs: ["com.flare.example.lifetime", "com.flare.example.lifetime_2"])
        )
        .padding()
    }
}

#Preview {
    ContentView()
}
