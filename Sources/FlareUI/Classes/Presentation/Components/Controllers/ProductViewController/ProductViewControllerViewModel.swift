//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import SwiftUI

@available(watchOS, unavailable)
final class ProductViewControllerViewModel: ObservableObject {
    @Published var onInAppPurchaseCompletion: PurchaseCompletionHandler?
    @Published var inAppPurchaseOptions: PurchaseOptionHandler?
    @Published var productStyle = AnyProductStyle(style: CompactProductStyle())
}
