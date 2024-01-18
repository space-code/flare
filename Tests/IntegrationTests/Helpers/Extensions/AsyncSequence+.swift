//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.2, *)
extension AsyncSequence {
    /// Returns the elements of the asynchronous sequence.
    func extractValues() async rethrows -> [Element] {
        try await reduce(into: []) {
            $0.append($1)
        }
    }
}
