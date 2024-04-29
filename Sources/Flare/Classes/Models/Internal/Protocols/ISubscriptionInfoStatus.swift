//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol ISubscriptionInfoStatus {
    var renewalState: RenewalState { get }
    var subscriptionRenewalInfo: VerificationResult<RenewalInfo> { get }
}
