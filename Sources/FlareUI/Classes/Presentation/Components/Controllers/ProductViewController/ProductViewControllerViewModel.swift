//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

class ProductViewControllerViewModel: ObservableObject {
    @Published var onInAppPurchaseCompletion: PurchaseCompletionHandler?
    @Published var inAppPurchaseOptions: PurchaseOptionHandler?
}
