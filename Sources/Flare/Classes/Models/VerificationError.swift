//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - VerificationError

/// Enumeration representing errors that can occur during verification.
public enum VerificationError: Error {
    /// The certificate chain was parsable, but was invalid due to one or more revoked certificates.
    ///
    /// Trying again later may retrieve valid signed data from the App Store.
    case revokedCertificate

    /// The certificate chain was parsable, but it was invalid for signing this data.
    case invalidCertificateChain

    /// The device verification properties were invalid for this device.
    case invalidDeviceVerification

    /// Th JWS header and any data included in it or it's certificate chain had an invalid encoding.
    case invalidEncoding

    /// The certificate chain was valid for signing this data, but the leaf's public key was invalid for the
    /// JWS signature.
    case invalidSignature

    /// Either the JWS header or any certificate in the chain was missing necessary properties for
    /// verification.
    case missingRequiredProperties

    /// Unknown error.
    case unknown(error: Error)
}

// MARK: - Initialization

extension VerificationError {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    init(_ verificationError: StoreKit.VerificationResult<some Any>.VerificationError) {
        switch verificationError {
        case .revokedCertificate:
            self = .revokedCertificate
        case .invalidCertificateChain:
            self = .invalidCertificateChain
        case .invalidDeviceVerification:
            self = .invalidDeviceVerification
        case .invalidEncoding:
            self = .invalidEncoding
        case .invalidSignature:
            self = .invalidSignature
        case .missingRequiredProperties:
            self = .missingRequiredProperties
        @unknown default:
            self = .unknown(error: verificationError)
        }
    }
}
