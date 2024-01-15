//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - PromotionalOffer

public final class PromotionalOffer: NSObject, Sendable {
    // MARK: Properties

    public let discount: StoreProductDiscount
    public let signedData: SignedData

    // MARK: Initialization

    public init(discount: StoreProductDiscount, signedData: SignedData) {
        self.discount = discount
        self.signedData = signedData
    }
}

// MARK: PromotionalOffer.SignedData

public extension PromotionalOffer {
    final class SignedData: NSObject, Sendable {
        // MARK: Properties

        public let identifier: String
        public let keyIdentifier: String
        public let nonce: UUID
        public let signature: String
        public let timestamp: Int

        public init(identifier: String, keyIdentifier: String, nonce: UUID, signature: String, timestamp: Int) {
            self.identifier = identifier
            self.keyIdentifier = keyIdentifier
            self.nonce = nonce
            self.signature = signature
            self.timestamp = timestamp
        }
    }
}

// MARK: - Convenience Initializators

extension PromotionalOffer.SignedData {
    convenience init(paymentDiscount: SKPaymentDiscount) {
        self.init(
            identifier: paymentDiscount.identifier,
            keyIdentifier: paymentDiscount.keyIdentifier,
            nonce: paymentDiscount.nonce,
            signature: paymentDiscount.signature,
            timestamp: paymentDiscount.timestamp.intValue
        )
    }
}

// MARK: - Helpers

extension PromotionalOffer.SignedData {
    var skPromotionalOffer: SKPaymentDiscount {
        SKPaymentDiscount(
            identifier: identifier,
            keyIdentifier: keyIdentifier,
            nonce: nonce,
            signature: signature,
            timestamp: .init(integerLiteral: timestamp)
        )
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    var promotionalOffer: Product.PurchaseOption {
        get throws {
            guard let data = Data(base64Encoded: signature) else {
                throw IAPError.failedToDecodeSignature(signature: signature)
            }

            return .promotionalOffer(
                offerID: identifier,
                keyID: keyIdentifier,
                nonce: nonce,
                signature: data,
                timestamp: timestamp
            )
        }
    }
}
