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
        private let scenesHolder: @Sendable () async -> IScenesHolder

        // MARK: Initialization

        init(scenesHolder: IScenesHolder? = nil) {
            if let scenesHolder {
                self.scenesHolder = { scenesHolder }
            } else {
                self.scenesHolder = {
                    await MainActor.run { UIApplication.shared }
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
                let holder = await scenesHolder()
                var scenes = holder.connectedScenes
                    .filter { $0.activationState == .foregroundActive }

                #if DEBUG && targetEnvironment(simulator)
                    if scenes.isEmpty, ProcessInfo.isRunningUnitTests {
                        scenes = holder.connectedScenes
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
