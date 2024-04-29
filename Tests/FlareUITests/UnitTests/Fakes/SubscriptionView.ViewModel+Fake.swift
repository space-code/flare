//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import FlareUI
import Foundation

@available(watchOS, unavailable)
extension SubscriptionView.ViewModel {
    static func fake(id: String? = nil) -> SubscriptionView.ViewModel {
        SubscriptionView.ViewModel(
            id: id ?? UUID().uuidString,
            title: "Title",
            price: "5,99$",
            description: "Description",
            isActive: true
        )
    }
}
