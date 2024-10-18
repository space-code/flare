//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import StoreKit

private nonisolated(unsafe) var requestIdKey: UInt = 0

extension SKRequest {
    var id: String {
        get {
            objc_getAssociatedObject(self, &requestIdKey) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &requestIdKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
