//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension AsyncSequence where Element: Sendable {
    func toAsyncStream() -> AsyncStream<Element> {
        var asyncIterator = makeAsyncIterator()
        return AsyncStream<Element> {
            try? await asyncIterator.next()
        }
    }
}
