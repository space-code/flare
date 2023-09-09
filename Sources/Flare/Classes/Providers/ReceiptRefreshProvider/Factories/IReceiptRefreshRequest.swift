//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

protocol IReceiptRefreshRequest {
    var id: String { get set }

    func start()
}
