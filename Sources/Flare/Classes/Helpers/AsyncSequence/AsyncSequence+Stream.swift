//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension AsyncSequence {
    func toAsyncStream() -> AsyncStream<Element> {
        var asyncIterator = makeAsyncIterator()
        return AsyncStream<Element> {
            try? await asyncIterator.next()
        }
    }
}
