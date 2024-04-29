//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

extension StringProtocol {
    var words: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}
