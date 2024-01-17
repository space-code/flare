//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import XCTest

@available(iOS 15.0, *)
final class EligibilityProviderTests: StoreSessionTestCase {
    // MARK: Properties

    private var sut: EligibilityProvider!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        sut = EligibilityProvider()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatProviderReturnsNoOffer_whenProductDoesNotHaveIntroductoryOffer() async throws {
        // given
        let product = try await ProductProviderHelper.subscriptionsWithoutOffers.randomElement()!

        // when
        let result = try await sut.checkEligibility(products: [StoreProduct(product: product)])

        // then
        XCTAssertEqual(result[product.id], .noOffer)
    }

    func test_thatProviderReturnsEligible_whenProductHasIntroductoryOffer() async throws {
        // given
        let product = try await ProductProviderHelper.subscriptionsWithOffers.randomElement()!

        // when
        let result = try await sut.checkEligibility(products: [StoreProduct(product: product)])

        // then
        XCTAssertEqual(result[product.id], .eligible)
    }
}
