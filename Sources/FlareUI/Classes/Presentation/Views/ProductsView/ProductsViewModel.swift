//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

struct ProductsViewModel {
    static let initial = ProductsViewModel(isLoading: false, products: [])

    let isLoading: Bool
    let products: [ProductView.ViewModel]
}
