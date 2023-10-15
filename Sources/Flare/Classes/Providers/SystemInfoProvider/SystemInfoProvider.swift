//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif

// MARK: - SystemInfoProvider

final class SystemInfoProvider {
    // MARK: Properties

    #if os(iOS) || VISION_OS
        private let scenesHolder: IScenesHolder

        // MARK: Initialization

        init(scenesHolder: IScenesHolder = UIApplication.shared) {
            self.scenesHolder = scenesHolder
        }
    #endif
}

// MARK: ISystemInfoProvider

extension SystemInfoProvider: ISystemInfoProvider {
    #if os(iOS) || VISION_OS
        @available(iOS 13.0, *)
        @available(macOS, unavailable)
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @MainActor
        var currentScene: UIWindowScene {
            get throws {
                var scenes = scenesHolder.connectedScenes
                    .filter { $0.activationState == .foregroundActive }

                #if DEBUG && targetEnvironment(simulator)
                    if scenes.isEmpty, ProcessInfo.isRunningUnitTests {
                        scenes = scenesHolder.connectedScenes
                    }
                #endif

                if let windowScene = scenes.first as? UIWindowScene {
                    return windowScene
                } else {
                    throw IAPError.unknown
                }
            }
        }
    #endif
}
