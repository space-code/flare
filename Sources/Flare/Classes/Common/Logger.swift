//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import Log

// MARK: - Logger

enum Logger {
    // MARK: Properties

    private static var defaultLogLevel: LogLevel {
        #if DEBUG
            return .debug
        #else
            return .info
        #endif
    }

    #if swift(>=6.0)
        private nonisolated(unsafe) static let `default`: Log.Logger = .init(
            printers: [
                ConsolePrinter(formatters: Self.formatters),
                OSPrinter(subsystem: .subsystem, category: .category, formatters: Self.formatters),
            ],
            logLevel: Self.defaultLogLevel
        )
    #else
        private static let `default`: Log.Logger = .init(
            printers: [
                ConsolePrinter(formatters: Self.formatters),
                OSPrinter(subsystem: .subsystem, category: .category, formatters: Self.formatters),
            ],
            logLevel: Self.defaultLogLevel
        )
    #endif

    private static var formatters: [ILogFormatter] {
        [
            PrefixLogFormatter(name: .subsystem),
            TimestampLogFormatter(dateFormat: "dd.MM.yyyy hh:mm:ss"),
        ]
    }

    static var logLevel: LogLevel {
        get { Self.default.logLevel }
        set { Self.default.updateLogLevel { _ in newValue } }
    }

    // MARK: Static Public Methods

    static func debug(message: @autoclosure () -> String) {
        log(level: .debug, message: message())
    }

    static func info(message: @autoclosure () -> String) {
        log(level: .info, message: message())
    }

    static func error(message: @autoclosure () -> String) {
        log(level: .fault, message: message())
    }

    // MARK: Private

    private static func log(level: LogLevel, message: @autoclosure () -> String) {
        switch level {
        case .debug:
            Self.default.debug(message: message())
        case .info:
            Self.default.info(message: message())
        case .fault:
            Self.default.fault(message: message())
        case .error:
            Self.default.error(message: message())
        default:
            break
        }
    }
}

// MARK: - Constants

private extension String {
    static let subsystem = "Flare"
    static let category = "iap"
}
