//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

#if canImport(UIKit)
    import UIKit
#elseif canImport(Cocoa)
    import Cocoa
#endif

// MARK: - SnapshotTestCase

@MainActor
@available(watchOS, unavailable)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
class SnapshotTestCase: XCTestCase {
    // MARK: Properties

    private var osName: String {
        #if os(iOS)
            return "iOS"
        #elseif os(macOS)
            return "macOS"
        #elseif os(tvOS)
            return "tvOS"
        #else
            return "unknown"
        #endif
    }

    // MARK: Tests

    func assertSnapshots(
        of view: some View,
        size: CGSize,
        userInterfaceStyle: UserInterfaceStyle = .light,
        file: StaticString = #filePath,
        testName: String = #function,
        line: UInt = #line
    ) {
        #if os(iOS) || os(tvOS)
            withSnapshotTesting(diffTool: .ksdiff) {
                SnapshotTesting.assertSnapshots(
                    of: view,
                    as: [
                        .image(
                            precision: 0.98,
                            perceptualPrecision: 0.98,
                            layout: .fixed(width: size.width, height: size.height),
                            traits: UITraitCollection(userInterfaceStyle: userInterfaceStyle.userInterfaceStyle)
                        ),
                    ],
                    file: file,
                    testName: testName + osName,
                    line: line
                )
            }
        #elseif os(macOS)
            SnapshotTesting.assertSnapshots(
                of: ThemableView(rootView: view, appearance: userInterfaceStyle.appearance),
                as: [.image(precision: 1.0, size: size)],
                file: file,
                testName: testName + osName,
                line: line
            )
        #endif
    }

    enum UserInterfaceStyle {
        case light, dark

        #if os(iOS) || os(tvOS)
            var userInterfaceStyle: UIUserInterfaceStyle {
                switch self {
                case .light:
                    .light
                case .dark:
                    .dark
                }
            }

        #elseif os(macOS)
            var appearance: NSAppearance? {
                switch self {
                case .light:
                    .init(named: .vibrantLight)
                case .dark:
                    .init(named: .darkAqua)
                }
            }
        #endif

        var colorScheme: ColorScheme {
            switch self {
            case .light:
                .light
            case .dark:
                .dark
            }
        }
    }
}
