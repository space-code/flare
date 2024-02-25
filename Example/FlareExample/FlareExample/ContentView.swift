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

// import StoreKit
//
// struct ContentView: View {
//    var body: some View {
//        ScrollView {
//            ProductView(id: "55667744") { _ in
//                Image(systemName: "crown")
//                    .resizable()
//                    .scaledToFit()
//            } placeholderIcon: {
//                ProgressView()
//            }
//            .productViewStyle(.large)
//
//            StoreView(
//                ids: [
//                    "123456789",
//                    "987654321"
//                ]
//            )
//            .productViewStyle(.compact)
//            .storeButton(.visible, for: .restorePurchases)
//        }
//    }
// }
