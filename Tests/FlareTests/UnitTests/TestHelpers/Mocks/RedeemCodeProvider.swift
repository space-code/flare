//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class RedeemCodeProviderMock: IRedeemCodeProvider {
    var invokedPresentOfferCodeRedeemSheet = false
    var invokedPresentOfferCodeRedeemSheetCount = 0

    func presentOfferCodeRedeemSheet() async {
        invokedPresentOfferCodeRedeemSheet = true
        invokedPresentOfferCodeRedeemSheetCount += 1
    }
}
