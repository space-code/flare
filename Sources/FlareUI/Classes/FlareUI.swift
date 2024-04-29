//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

public final class FlareUI: IFlareUI {
    // MARK: Properties

    private let dependencies: IFlareDependencies

    private let configurationProvider: IConfigurationProvider

    /// The singleton instance.
    private static let flareUI: FlareUI = .init()

    /// Returns a shared `Flare` object.
    public static var shared: IFlareUI { flareUI }

    // MARK: Initialization

    init(dependencies: IFlareDependencies = FlareDependencies()) {
        self.dependencies = dependencies
        self.configurationProvider = dependencies.configurationProvider
    }

    // MARK: Public

    /// Configures the FlareUI package with the provided configuration.
    ///
    /// - Parameters:
    ///   - configuration: The configuration object containing settings for FlareUI.
    public static func configure(with configuration: UIConfiguration) {
        flareUI.configurationProvider.configure(with: configuration)
    }
}
