//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

protocol IModel {
    associatedtype State

    var state: State { get }

    func setState(_ state: State) -> Self
}
