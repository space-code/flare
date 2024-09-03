//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - StoreEnvironment

enum StoreEnvironment {
    case production
    case sandbox
    case xcode
}

extension StoreEnvironment {
    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    init?(environment: StoreKit.AppStore.Environment) {
        switch environment {
        case .production:
            self = .production
        case .sandbox:
            self = .sandbox
        case .xcode:
            self = .xcode
        default:
            return nil
        }
    }

    init?(environment: String) {
        switch environment {
        case "Production":
            self = .production
        case "Sandbox":
            self = .sandbox
        case "Xcode":
            self = .xcode
        default:
            return nil
        }
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    init?(transaction: StoreKit.Transaction) {
        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            self.init(environment: transaction.environment)
        } else {
            #if VISION_OS
                self.init(environment: transaction.environment)
            #else
                self.init(
                    environment: transaction.environmentStringRepresentation
                )
            #endif
        }
    }
}
