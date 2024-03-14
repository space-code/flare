//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SwiftUI
import UIKit

struct ActivityIndicatorView: UIViewRepresentable {
    // MARK: Properties

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    // MARK: UIViewRepresentable

    func makeUIView(context _: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context _: UIViewRepresentableContext<ActivityIndicatorView>
    ) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
