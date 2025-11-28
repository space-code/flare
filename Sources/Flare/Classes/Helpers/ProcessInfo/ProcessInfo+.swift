//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

#if DEBUG
    extension ProcessInfo {
        static var isRunningUnitTests: Bool {
            self[.XCTestConfigurationFile] != nil
        }
    }

    // MARK: - Extensions

    extension ProcessInfo {
        static subscript(key: String) -> String? {
            processInfo.environment[key]
        }
    }

    // MARK: - Constants

    private extension String {
        static let XCTestConfigurationFile = "XCTestConfigurationFilePath"
    }

#endif
