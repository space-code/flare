//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, macOS 11.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
final class SubscriptionsViewControllerViewModel: ObservableObject {
    @Published var onInAppPurchaseCompletion: PurchaseCompletionHandler?
    @Published var inAppPurchaseOptions: PurchaseOptionHandler?
    @Published var marketingContent: AnyView?
    @Published var subscriptionButtonLabelStyle: SubscriptionStoreButtonLabel = .action
    @Published var subscriptionBackgroundColor: Color = .clear
    @Published var subscriptionViewTintColor: Color = .blue
    @Published var subscriptionControlStyle: AnySubscriptionControlStyle = .init(style: AutomaticSubscriptionControlStyle())
    @Published var visibleStoreButtons: [StoreButtonType] = []
    @Published var hiddenStoreButtons: [StoreButtonType] = []
    #if os(iOS) || os(tvOS)
        @Published var subscriptionHeaderContentBackground: Color = .clear
    #endif
    #if os(iOS)
        @Published var subscriptionPrivacyPolicyURL: URL?
        @Published var subscriptionTermsOfServiceURL: URL?
    #endif
    @Published var subscriptionPrivacyPolicyView: AnyView?
    @Published var subscriptionTermsOfServiceView: AnyView?
}
