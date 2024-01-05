//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

@testable import Flare
import Foundation

final class AppStoreReceiptProviderMock: IAppStoreReceiptProvider {
    var invokedAppStoreReceiptURLGetter = false
    var invokedAppStoreReceiptURLGetterCount = 0
    var stubbedAppStoreReceiptURL: URL!

    var appStoreReceiptURL: URL? {
        invokedAppStoreReceiptURLGetter = true
        invokedAppStoreReceiptURLGetterCount += 1
        return stubbedAppStoreReceiptURL
    }
}
