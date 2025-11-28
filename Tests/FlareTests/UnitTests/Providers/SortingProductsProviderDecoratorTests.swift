//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

@testable import Flare
import FlareMock
import XCTest

// MARK: - SortingProductsProviderDecoratorTests

final class SortingProductsProviderDecoratorTests: XCTestCase {
    // MARK: Properties

    private var productProviderMock: ProductProviderMock!

    private var sut: SortingProductsProviderDecorator!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
        productProviderMock = ProductProviderMock()
        sut = SortingProductsProviderDecorator(productProvider: productProviderMock)
    }

    override func tearDown() {
        productProviderMock = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Tests

    func test_ProductProviderSortsSetItems_whenFetchProducts() async {
        await test_sort(collection: Set.productIDs)
    }

    func test_ProductProviderSortsArrayItems_whenFetchProducts() async {
        await test_sort(collection: Array.productIDs)
    }

    // MARK: Private

    private func test_sort(collection: some Collection<String>) async {
        // given
        let ids = collection
        let arrayIDs = Array(ids)
        let products: [StoreProduct] = ids
            .map { .fake(productIdentifier: $0) }
            .shuffled()
        productProviderMock.stubbedFetchResult = .success(products)

        // when
        sut.fetch(productIDs: ids, requestID: .requestID) { result in
            if case let .success(products) = result {
                XCTAssertEqual(arrayIDs.count, products.count)
                XCTAssertEqual(arrayIDs, products.map(\.productIdentifier))
            } else {
                XCTFail("Fetch resulted in an unknown state.")
            }
        }
    }
}

// MARK: - Constants

private extension String {
    static let requestID = "requestID"
}

private extension [String] {
    static let productIDs: [Element] = ["1", "2", "3"]
}

private extension Set<String> {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
