//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

/// Type that retrieves the App Store receipt URL.
protocol IAppStoreReceiptProvider {
    /// The App Store receipt URL for the app.
    var appStoreReceiptURL: URL? { get }
}
