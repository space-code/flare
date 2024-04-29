//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

#if os(iOS)
    import SafariServices
    import SwiftUI

    struct SafariWebView: UIViewControllerRepresentable {
        let url: URL

        func makeUIViewController(context _: Context) -> SFSafariViewController {
            SFSafariViewController(url: url)
        }

        func updateUIViewController(_: SFSafariViewController, context _: Context) {}
    }
#endif
