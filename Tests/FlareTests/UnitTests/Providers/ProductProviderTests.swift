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

class ProductProviderTests: XCTestCase {
    // MARK: - Properties

    private var testDispatchQueue: TestDispatchQueue!
    private var dispatchQueueFactory: IDispatchQueueFactory!
    private var productProvider: ProductProvider!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()
        testDispatchQueue = TestDispatchQueue()
        dispatchQueueFactory = TestDispatchQueueFactory(testQueue: testDispatchQueue)
        productProvider = ProductProvider(dispatchQueueFactory: dispatchQueueFactory)
    }

    override func tearDown() {
        testDispatchQueue = nil
        dispatchQueueFactory = nil
        productProvider = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test_thatProductProviderReturnsInvalidProductIDs_whenRequestProductsWithInvalidIDs() {
        // given
        var fetchResult: Result<[SKProduct], IAPError>?
        let completionHandler: IProductProvider.ProductsHandler = { result in fetchResult = result }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let response = ProductResponseMock()

        response.stubbedInvokedInvalidProductsIdentifiers = [.productID]

        // when
        productProvider.fetch(productIDs: .productIDs, requestID: .requestID, completion: completionHandler)
        productProvider.productsRequest(request, didReceive: response)

        // then
        if case let .failure(error) = fetchResult, case let .invalid(products) = error {
            XCTAssertEqual(products, response.invalidProductIdentifiers)
        } else {
            XCTFail()
        }
    }

    func test_thatProductProviderReturnsProducts_whenRequestProductsWithValidProductIDs() {
        // given
        var fetchResult: Result<[SKProduct], IAPError>?
        let completionHandler: IProductProvider.ProductsHandler = { result in fetchResult = result }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let response = ProductResponseMock()

        // when
        productProvider.fetch(productIDs: .productIDs, requestID: .requestID, completion: completionHandler)
        productProvider.productsRequest(request, didReceive: response)

        // then
        if case let .success(products) = fetchResult {
            XCTAssertEqual(products, response.products)
        } else {
            XCTFail()
        }
    }

    func test_thatProductProviderHandlesError_whenRequestDidFailWithError() {
        // given
        var fetchResult: Result<[SKProduct], IAPError>?
        let completionHandler: IProductProvider.ProductsHandler = { result in fetchResult = result }
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let error = IAPError.emptyProducts

        // when
        productProvider.fetch(productIDs: .productIDs, requestID: .requestID, completion: completionHandler)
        productProvider.request(request, didFailWithError: error)

        // then
        if case let .failure(resultError) = fetchResult {
            XCTAssertEqual(resultError.plainError as NSError, error.plainError as NSError)
        } else {
            XCTFail()
        }
    }
}

// MARK: - Constants

private extension String {
    static let productID = "product_ID"
    static let requestID = "request_identifier"
}

private extension Set where Element == String {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
