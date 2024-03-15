//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import XCTest

// MARK: - CachingProductsProviderDecoratorTests

final class CachingProductsProviderDecoratorTests: XCTestCase {
    // MARK: Properties

    private var productProviderMock: ProductProviderMock!
    private var configurationProviderMock: ConfigurationProviderMock!

    private var sut: CachingProductsProviderDecorator!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        productProviderMock = ProductProviderMock()
        configurationProviderMock = ConfigurationProviderMock()
        sut = CachingProductsProviderDecorator(
            productProvider: productProviderMock,
            configurationProvider: configurationProviderMock
        )
    }

    override func tearDown() {
        productProviderMock = nil
        configurationProviderMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_thatProviderFetchesCachedProducts_whenFetchCachePolicyIsCachedOrFetch() {
        // given
        configurationProviderMock.stubbedFetchCachePolicy = .cachedOrFetch
        productProviderMock.stubbedFetchResult = .success([StoreProduct.fake(productIdentifier: .productID)])

        // when
        sut.fetch(productIDs: [.productID], requestID: "", completion: { _ in })
        sut.fetch(productIDs: [.productID], requestID: "", completion: { _ in })

        // then
        XCTAssertEqual(productProviderMock.invokedFetchCount, 1)
    }

    func test_thatProviderFetchesProducts_whenFetchCachePolicyIsFetch() {
        // given
        configurationProviderMock.stubbedFetchCachePolicy = .fetch
        productProviderMock.stubbedFetchResult = .success([StoreProduct.fake()])

        // when
        sut.fetch(productIDs: [.productID], requestID: "", completion: { _ in })
        sut.fetch(productIDs: [.productID], requestID: "", completion: { _ in })

        // then
        XCTAssertEqual(productProviderMock.invokedFetchCount, 2)
    }

    func test_thatProviderThrowsAnError_whenFetchDidFail() {
        // given
        configurationProviderMock.stubbedFetchCachePolicy = .cachedOrFetch
        productProviderMock.stubbedFetchResult = .failure(.unknown)

        // when
        sut.fetch(productIDs: [.productID], requestID: "", completion: { XCTAssertEqual($0.error, .unknown) })

        // then
        XCTAssertEqual(productProviderMock.invokedFetchCount, 1)
    }
}

// MARK: - Constants

private extension String {
    static let productID = "product_id"
}
