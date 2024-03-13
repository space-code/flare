//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

@available(watchOS, unavailable)
final class ProductsViewControllerViewModel: ObservableObject {
    @Published var onInAppPurchaseCompletion: PurchaseCompletionHandler?
    @Published var visibleStoreButtons: [StoreButtonType] = []
    @Published var hiddenStoreButtons: [StoreButtonType] = []
    @Published var inAppPurchaseOptions: PurchaseOptionHandler?
}
