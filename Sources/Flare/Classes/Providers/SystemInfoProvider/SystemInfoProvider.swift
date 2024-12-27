//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

#if canImport(UIKit)
    import UIKit
#endif

// MARK: - SystemInfoProvider

final class SystemInfoProvider: @unchecked Sendable {
    // MARK: Properties

    #if os(iOS) || VISION_OS
        private let scenesHolder: () async -> Set<UIScene>

        // MARK: Initialization

        init(scenesHolder: IScenesHolder? = nil) {
            if let scenesHolder {
                self.scenesHolder = { await scenesHolder.connectedScenes }
            } else {
                self.scenesHolder = {
                    await UIApplication.shared.connectedScenes
                }
            }
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
            get async throws {
                var scenes = await scenesHolder()
                    .filter { $0.activationState == .foregroundActive }

                #if DEBUG && targetEnvironment(simulator)
                    if scenes.isEmpty, ProcessInfo.isRunningUnitTests {
                        scenes = await scenesHolder()
                    }
                #endif

                guard let windowScene = scenes.first as? UIWindowScene else {
                    throw IAPError.unknown
                }

                return windowScene
            }
        }
    #endif
}
