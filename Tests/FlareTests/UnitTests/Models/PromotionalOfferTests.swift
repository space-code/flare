//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import StoreKit
import XCTest

// MARK: - PromotionalOfferTests

final class PromotionalOfferTests: XCTestCase {
    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_purchaseOptions() throws {
        let option = try PromotionalOffer.SignedData.randomOffer.promotionalOffer
        let expected: Product.PurchaseOption = .promotionalOffer(
            offerID: PromotionalOffer.SignedData.randomOffer.identifier,
            keyID: PromotionalOffer.SignedData.randomOffer.keyIdentifier,
            nonce: PromotionalOffer.SignedData.randomOffer.nonce,
            signature: Data(),
            timestamp: PromotionalOffer.SignedData.randomOffer.timestamp
        )

        XCTAssertEqual(expected, option)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_purchaseOptionWithInvalidSignatureThrows() throws {
        do {
            _ = try PromotionalOffer.SignedData.invalidOffer.promotionalOffer
        } catch {
            let error = try XCTUnwrap(error as? IAPError)
            XCTAssertEqual(error, IAPError.failedToDecodeSignature(signature: PromotionalOffer.SignedData.invalidOffer.signature))
        }
    }
}

// MARK: - Constants

private extension PromotionalOffer.SignedData {
    static let randomOffer: PromotionalOffer.SignedData = .init(
        identifier: "identifier \(Int.random(in: 0 ..< 1000))",
        keyIdentifier: "key identifier \(Int.random(in: 0 ..< 1000))",
        nonce: .init(),
        signature: "signature \(Int.random(in: 0 ..< 1000))".asData.base64EncodedString(),
        timestamp: Int.random(in: 0 ..< 1000)
    )

    static let invalidOffer: PromotionalOffer.SignedData = .init(
        identifier: "identifier \(Int.random(in: 0 ..< 1000))",
        keyIdentifier: "key identifier \(Int.random(in: 0 ..< 1000))",
        nonce: .init(),
        signature: "signature \(Int.random(in: 0 ..< 1000))",
        timestamp: Int.random(in: 0 ..< 1000)
    )
}
