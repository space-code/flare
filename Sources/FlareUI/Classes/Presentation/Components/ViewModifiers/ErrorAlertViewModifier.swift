//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ErrorAlertViewModifier

/// A view modifier that handles an error alert.
struct ErrorAlertViewModifier: ViewModifier {
    // MARK: Properties

    /// An error to be presented.
    @Binding private var error: Error?

    /// A binding to control the presentation state of the error.
    private var isErrorPresented: Binding<Bool> {
        Binding { error != nil } set: { _ in error = nil }
    }

    // MARK: Initialization

    /// Creates an ``ErrorAlertViewModifier`` instance.
    ///
    /// - Parameter error: A binding to control the presentation state of the error.
    init(error: Binding<Error?>) {
        _error = error
    }

    // MARK: ViewModifier

    func body(content: Content) -> some View {
        content
            .alert(isPresented: isErrorPresented) {
                Alert(title: Text("Error Occurred"), message: Text(error?.localizedDescription ?? ""))
            }
    }
}

// MARK: - Extensions

extension View {
    func errorAlert(_ error: Binding<Error?>) -> some View {
        modifier(ErrorAlertViewModifier(error: error))
    }
}
