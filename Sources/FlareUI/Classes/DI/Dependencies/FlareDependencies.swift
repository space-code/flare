//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Flare

final class FlareDependencies: IFlareDependencies {
    // MARK: IFlareDependencies

    var iap: IFlare {
        Flare.shared
    }
}