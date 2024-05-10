//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation

/// The class provides a way to configure the UI module.
public final class FlareUI: IFlareUI {
    // MARK: Properties

    /// The dependencies for FlareUI.
    private let dependencies: IFlareDependencies

    /// The configuration provider for FlareUI.
    private let configurationProvider: IConfigurationProvider

    /// The singleton instance.
    private static let flareUI: FlareUI = .init()

    /// Returns a shared `Flare` object.
    public static var shared: IFlareUI { flareUI }

    // MARK: Initialization

    /// Initializes a new instance of FlareUI with the provided dependencies.
    ///
    /// - Parameter dependencies: The dependencies for FlareUI. Default is FlareDependencies().
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
