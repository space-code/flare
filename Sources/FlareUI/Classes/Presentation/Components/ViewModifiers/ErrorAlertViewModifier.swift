//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI

// MARK: - ErrorAlertViewModifier

struct ErrorAlertViewModifier: ViewModifier {
    // MARK: Properties

    @Binding private var error: Error?

    private var isErrorPresented: Binding<Bool> {
        Binding { error != nil } set: { _ in error = nil }
    }

    init(error: Binding<Error?>) {
        _error = error
    }

    func body(content: Content) -> some View {
        content
            .alert(isPresented: isErrorPresented) {
                Alert(title: Text("Error Occurred"), message: Text(error?.localizedDescription ?? ""))
            }
    }
}

extension View {
    func errorAlert(_ error: Binding<Error?>) -> some View {
        modifier(ErrorAlertViewModifier(error: error))
    }
}
