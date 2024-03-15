//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare
import Foundation

// MARK: - ISubscriptionDateComponentsFactory

protocol ISubscriptionDateComponentsFactory {
    func dateComponents(for subscription: SubscriptionPeriod) -> DateComponents
}

// MARK: - SubscriptionDateComponentsFactory

final class SubscriptionDateComponentsFactory: ISubscriptionDateComponentsFactory {
    func dateComponents(for subscription: SubscriptionPeriod) -> DateComponents {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        let numberOfUnits = subscription.value

        switch subscription.unit {
        case .day:
            dateComponents.setValue(numberOfUnits, for: .day)
        case .week:
            dateComponents.setValue(numberOfUnits, for: .weekOfMonth)
        case .month:
            dateComponents.setValue(numberOfUnits, for: .month)
        case .year:
            dateComponents.setValue(numberOfUnits, for: .year)
        }

        return dateComponents
    }
}
