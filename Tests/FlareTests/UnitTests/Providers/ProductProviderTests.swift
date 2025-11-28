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

    func test_thatProductProviderReturnsInvalidProductIDs_whenRequestProductsAreFetchedWithInvalidIDs() async throws {
        // given
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let response = ProductResponseMock()

        response.stubbedInvokedInvalidProductsIdentifiers = [.productID]

        // when
        let fetchResult: Result<[StoreProduct], IAPError>? = try await withCheckedThrowingContinuation { continuation in
            sut.fetch(productIDs: Set.productIDs, requestID: .requestID) { result in
                continuation.resume(returning: result)
            }

            sut.productsRequest(request, didReceive: response)
        }

        // then
        if case let .failure(error) = fetchResult, case let .invalid(products) = error {
            XCTAssertEqual(products, response.invalidProductIdentifiers)
        } else {
            XCTFail()
        }
    }

    func test_thatProductProviderReturnsProducts_whenRequestProductsAreFetchedWithValidProductIDs() async throws {
        // given
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let response = ProductResponseMock()

        // when
        let fetchResult: Result<[StoreProduct], IAPError>? = try await withCheckedThrowingContinuation { continuation in
            sut.fetch(productIDs: Set.productIDs, requestID: .requestID) { result in
                continuation.resume(returning: result)
            }

            sut.productsRequest(request, didReceive: response)
        }

        // then
        XCTAssertEqual(fetchResult?.success?.compactMap { $0.product as? SK1StoreProduct }.map(\.product), response.products)
    }

    func test_thatProductProviderHandlesError_whenRequestDidFailWithError() async throws {
        // given
        let request = PurchaseManagerTestHelper.makeRequest(with: .requestID)
        let errorStub = IAPError.unknown

        // when
        let fetchResult: Result<[StoreProduct], IAPError>? = try await withCheckedThrowingContinuation { continuation in
            sut.fetch(productIDs: Set.productIDs, requestID: .requestID) { result in
                continuation.resume(returning: result)
            }

            sut.request(request, didFailWithError: errorStub)
        }

        // then
        XCTAssertEqual(fetchResult?.error?.plainError as? NSError, errorStub.plainError as NSError)
    }
}

// MARK: - Constants

private extension String {
    static let productID = "com.flare.test_purchase_1"
    static let requestID = "request_identifier"
}

private extension Set<String> {
    static let productIDs: Set<Element> = .init(arrayLiteral: "1", "2", "3")
}
