//
// Flare
// Copyright © 2023 Space Code. All rights reserved.
//

import Concurrency
@testable import Flare
import StoreKit
import TestConcurrency
import XCTest

// MARK: - ProductProviderTests

final class ProductProviderTests: XCTestCase {
    // MARK: - Properties

    private var testDispatchQueue: TestDispatchQueue!
    private var dispatchQueueFactory: IDispatchQueueFactory!

    private var sut: ProductProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        sut = ProductProvider(dispatchQueueFactory: dispatchQueueFactory)
    }

    override func tearDown() {
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatProductProviderReturnsInvalidProductIDs_whenRequestProductsAreFetchedWithInvalidIDs() {
        // given
        var fetchResult: Result<[SK1StoreProduct], IAPError>?
        let completionHandler: IProductProvider.ProductsHandler = { result in fetchResult = result }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let response = ProductResponseMock()

        response.stubbedInvokedInvalidProductsIdentifiers = [.productID]

        // when
        sut.fetch(productIDs: .productIDs, requestID: .requestID, completion: completionHandler)
        sut.productsRequest(request, didReceive: response)

        // then
        if case let .failure(error) = fetchResult, case let .invalid(products) = error {
            XCTAssertEqual(products, response.invalidProductIdentifiers)
        } else {
            XCTFail()
        }
    }

    func test_thatProductProviderReturnsProducts_whenRequestProductsAreFetchedWithValidProductIDs() {
        // given
        var products: [SK1StoreProduct]? = []
        let completionHandler: IProductProvider.ProductsHandler = { products = $0.success }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let response = ProductResponseMock()

        // when
        sut.fetch(productIDs: .productIDs, requestID: .requestID, completion: completionHandler)
        sut.productsRequest(request, didReceive: response)

        // then
        XCTAssertEqual(products?.map(\.product), response.products)
    }

    func test_thatProductProviderHandlesError_whenRequestDidFailWithError() {
        // given
        var error: IAPError?
        let completionHandler: IProductProvider.ProductsHandler = { error = $0.error }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let errorStub = IAPError.emptyProducts

        // when
        sut.fetch(productIDs: .productIDs, requestID: .requestID, completion: completionHandler)
        sut.request(request, didFailWithError: errorStub)

        // then
        XCTAssertEqual(error?.plainError as? NSError, errorStub.plainError as NSError)
    }

    @available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
    func test_thatProductProvider() async throws {
        // when
        let products = try await sut.fetch(productIDs: [.productID])

        // then
        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.productIdentifier, .productID)
    }
}

// MARK: - Constants

private extension String {
    static let productID = "com.flare.test_purchase_1"
    static let requestID = "request_identifier"
}

private extension Set where Element == String {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
