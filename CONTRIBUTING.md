# Contributing to Flare

First off, thank you for considering contributing to Flare! It's people like you that make Flare such a great tool for working with in-app purchases.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
  - [Development Setup](#development-setup)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Improving Documentation](#improving-documentation)
  - [Submitting Code](#submitting-code)
- [Development Workflow](#development-workflow)
  - [Branching Strategy](#branching-strategy)
  - [Commit Guidelines](#commit-guidelines)
  - [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
  - [Swift Style Guide](#swift-style-guide)
  - [Code Quality](#code-quality)
  - [Testing Requirements](#testing-requirements)
- [Community](#community)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to nv3212@gmail.com.

## Getting Started

### Development Setup

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/flare.git
   cd flare
   ```

3. **Set up the development environment**
   ```bash
   # Install mise (if not already installed)
   curl https://mise.run | sh
   
   # Install project dependencies
   mise install
   ```

4. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

5. **Open the project in Xcode**
   ```bash
   open Package.swift
   ```

## How Can I Contribute?

### Reporting Bugs

Before creating a bug report, please check the [existing issues](https://github.com/space-code/flare/issues) to avoid duplicates.

When creating a bug report, use our [bug report template](.github/ISSUE_TEMPLATE/bug_report.md) and include:

- **Clear title** - Describe the issue concisely
- **Reproduction steps** - Detailed steps to reproduce the bug
- **Expected behavior** - What you expected to happen
- **Actual behavior** - What actually happened
- **Environment** - OS, Xcode version, Swift version, StoreKit version
- **Code samples** - Minimal reproducible example
- **Console logs** - Relevant error messages or logs
- **Screenshots** - If applicable (especially for UI issues)

**Example:**
```markdown
**Title:** Purchase completion handler not called for cancelled transactions

**Steps to reproduce:**
1. Call Flare.shared.purchase(product: product)
2. Cancel the purchase dialog
3. Completion handler is never invoked

**Expected:** Completion called with .cancelled result
**Actual:** No callback, causing UI to hang

**Environment:**
- iOS 17.0
- Xcode 15.3
- Flare 3.1.0
- Testing on physical device (iPhone 15 Pro)
```

### Suggesting Features

We love feature suggestions! Use our [feature request template](.github/ISSUE_TEMPLATE/feature_request.md) and include:

- **Problem statement** - What problem does this solve?
- **Proposed solution** - How should it work?
- **Alternatives** - What alternatives did you consider?
- **Use cases** - Real-world scenarios where this would be useful
- **API design** - Example code showing proposed usage
- **StoreKit compatibility** - Consider both StoreKit 1 and 2

**Example:**
```markdown
**Problem:** Difficult to track subscription renewal dates

**Proposed solution:**
Add a method to get the next renewal date for active subscriptions:
```swift
let renewalDate = try await Flare.shared.renewalDate(for: subscription)
```

**Use cases:**
- Display "Next billing date" in subscription management UI
- Send reminders before renewal
- Analytics on subscription lifecycle
```

### Improving Documentation

Documentation improvements are always welcome:

- **Code comments** - Add/improve inline documentation
- **API documentation** - Enhance DocC documentation
- **README** - Fix typos, add examples, improve clarity
- **Guides** - Write tutorials or how-to guides
- **Code examples** - Add sample code for common use cases
- **Translations** - Help translate documentation

Use our [documentation template](.github/ISSUE_TEMPLATE/documentation.md) for documentation issues.

### Submitting Code

1. **Check existing work** - Look for related issues or PRs
2. **Discuss major changes** - Open an issue for large features
3. **Follow coding standards** - See [Coding Standards](#coding-standards)
4. **Write tests** - All code changes require tests
5. **Update documentation** - Keep docs in sync with code
6. **Test on devices** - Test purchases on physical devices when possible
7. **Create a pull request** - Use our [PR template](.github/PULL_REQUEST_TEMPLATE.md)

## Development Workflow

### Branching Strategy

We follow a simplified Git Flow:

- **`main`** - Main development branch (default, all PRs target this branch)
- **`feature/*`** - New features
- **`fix/*`** - Bug fixes
- **`docs/*`** - Documentation updates
- **`refactor/*`** - Code refactoring
- **`test/*`** - Test improvements

**Branch naming examples:**
```bash
feature/promotional-offers-support
fix/transaction-finish-callback
docs/update-swiftui-examples
refactor/storekit2-implementation
test/add-subscription-tests
```

### Commit Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org/) for clear, structured commit history.

**Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style (formatting, missing semicolons)
- `refactor` - Code refactoring
- `test` - Adding or updating tests
- `chore` - Maintenance tasks (dependencies, tooling)
- `perf` - Performance improvements
- `ci` - CI/CD changes

**Scopes:**
- `core` - Core Flare framework changes
- `ui` - FlareUI changes
- `storekit1` - StoreKit 1 implementation
- `storekit2` - StoreKit 2 implementation
- `purchases` - Purchase handling logic
- `subscriptions` - Subscription-specific features
- `transactions` - Transaction management
- `swiftui` - SwiftUI components
- `uikit` - UIKit components
- `deps` - Dependencies

**Examples:**
```bash
feat(subscriptions): add support for promotional offers

Implement promotional offer support for subscriptions including:
- Offer signature validation
- Offer redemption flow
- Error handling for invalid offers

Closes #123

---

fix(transactions): handle finish completion callback correctly

Previously, the finish completion handler was not called when
transactions failed to finish. Now properly invokes callback
with error result.

Fixes #456

---

docs(swiftui): add subscription management examples

Add comprehensive examples for subscription management including:
- Displaying active subscriptions
- Handling subscription upgrades/downgrades
- Restoring purchases

---

test(purchases): increase coverage for purchase flow

Add tests for:
- Cancelled purchases
- Failed purchases with various error codes
- Pending purchases (Ask to Buy)
- Purchase restoration

---

refactor(core): modernize async/await implementation

Replace completion handler based APIs with async/await
for better readability and error handling.

BREAKING CHANGE: Some APIs now use async/await instead of completion handlers
```

**Commit message rules:**
- Use imperative mood ("add" not "added")
- Don't capitalize first letter
- No period at the end
- Keep subject line under 72 characters
- Separate subject from body with blank line
- Reference issues in footer
- Mark breaking changes with `BREAKING CHANGE:` in footer

### Pull Request Process

1. **Update your branch**
   ```bash
   git checkout main
   git pull upstream main
   git checkout feature/your-feature
   git rebase main
   ```

2. **Run tests and checks**
   ```bash
   # Run all tests
   swift test
   
   # Run specific test suite
   swift test --filter FlareTests
   
   # Check code formatting
   mise run lint
   
   # Build for all platforms
   swift build --platform ios
   swift build --platform macos
   swift build --platform tvos
   swift build --platform watchos
   ```

3. **Push to your fork**
   ```bash
   git push origin feature/your-feature
   ```

4. **Create pull request**
   - Use our [PR template](.github/PULL_REQUEST_TEMPLATE.md)
   - Target the `main` branch
   - Link related issues
   - Add screenshots/videos for UI changes
   - Describe testing performed (devices, scenarios)
   - Request review from maintainers

5. **Review process**
   - Address review comments promptly
   - Keep PR up to date with main branch
   - Squash commits if requested
   - Wait for all CI checks to pass
   - Ensure test coverage meets requirements

6. **After merge**
   ```bash
   # Clean up local branch
   git checkout main
   git pull upstream main
   git branch -d feature/your-feature
   
   # Clean up remote branch
   git push origin --delete feature/your-feature
   ```

## Coding Standards

### Swift Style Guide

We follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) and [Ray Wenderlich Swift Style Guide](https://github.com/raywenderlich/swift-style-guide).

**Key points:**

1. **Naming**
   ```swift
   // ✅ Good
   func purchase(product: Product) async throws -> PurchaseResult
   let isSubscriptionActive: Bool
   
   // ❌ Bad
   func buy(prod: Product) async throws -> Bool
   let active: Bool
   ```

2. **Protocols**
   ```swift
   // ✅ Good - Use "I" prefix for protocols
   protocol IFlareProvider {
       func products(productIDs: [String]) async throws -> [Product]
       func purchase(product: Product) async throws -> PurchaseResult
   }
   
   // ❌ Bad
   protocol FlareProvider { }
   ```

3. **Access Control**
   ```swift
   // ✅ Good - Explicit access control
   public final class Flare: IFlareProvider {
       private let storeKitProvider: IStoreKitProvider
       private var transactionObserver: TransactionObserver?
       
       public static let shared = Flare()
       
       private init() {
           self.storeKitProvider = StoreKitProvider()
       }
   }
   ```

4. **Async/Await**
   ```swift
   // ✅ Good - Use async/await for asynchronous operations
   public func purchase(product: Product) async throws -> PurchaseResult {
       let result = try await storeKitProvider.purchase(product)
       return result
   }
   
   // ❌ Bad - Don't use completion handlers for new code
   public func purchase(product: Product, completion: @escaping (Result<PurchaseResult, Error>) -> Void) {
       // ...
   }
   ```

5. **Documentation**
   ```swift
   /// Purchases a product from the App Store.
   ///
   /// This method handles the complete purchase flow including:
   /// - User authentication
   /// - Payment processing
   /// - Transaction verification
   ///
   /// - Parameters:
   ///   - product: The product to purchase
   ///   - promotionalOffer: Optional promotional offer to apply
   ///
   /// - Returns: The result of the purchase operation
   /// - Throws: `FlareError` if the purchase fails
   ///
   /// - Example:
   /// ```swift
   /// let product = try await Flare.shared.products(productIDs: ["premium"]).first!
   /// let result = try await Flare.shared.purchase(product: product)
   /// if case .purchased(let transaction) = result {
   ///     print("Purchase successful!")
   /// }
   /// ```
   ///
   /// - Important: Always call `finish(transaction:)` after successfully processing a purchase.
   /// - Note: This method must be called from the main thread.
   public func purchase(
       product: Product,
       promotionalOffer: PromotionalOffer? = nil
   ) async throws -> PurchaseResult {
       // Implementation
   }
   ```

### Code Quality

- **No force unwrapping** - Use optional binding or guards
- **No force casting** - Use conditional casting
- **No magic numbers** - Use named constants
- **Single responsibility** - One class, one purpose
- **DRY principle** - Don't repeat yourself
- **SOLID principles** - Follow SOLID design
- **Error handling** - Always handle errors gracefully
- **Thread safety** - Ensure thread-safe access to shared resources

**Example:**
```swift
// ✅ Good
private enum Constants {
    static let maxRetryAttempts = 3
    static let retryDelay: TimeInterval = 1.0
}

public func fetchProducts(productIDs: [String]) async throws -> [Product] {
    guard !productIDs.isEmpty else {
        throw FlareError.invalidProductIDs
    }
    
    let products = try await storeKitProvider.products(for: productIDs)
    
    guard !products.isEmpty else {
        throw FlareError.productsNotFound
    }
    
    return products
}

// ❌ Bad
public func fetchProducts(productIDs: [String]) async throws -> [Product] {
    let products = try await storeKitProvider.products(for: productIDs)
    return products
}
```

### Testing Requirements

All code changes must include comprehensive tests:

1. **Unit tests** - Test individual components in isolation
2. **Integration tests** - Test component interactions
3. **Edge cases** - Test boundary conditions
4. **Error handling** - Test all failure scenarios
5. **Snapshot tests** - For UI components (FlareUI)

**Coverage requirements:**
- New code: minimum 80% coverage
- Modified code: maintain or improve existing coverage
- Critical paths (purchases, transactions): 100% coverage

**Test structure:**
```swift
import XCTest
@testable import Flare

final class PurchaseFlowTests: XCTestCase {
    var sut: Flare!
    var mockStoreKit: MockStoreKitProvider!
    
    override func setUp() {
        super.setUp()
        mockStoreKit = MockStoreKitProvider()
        sut = Flare(storeKitProvider: mockStoreKit)
    }
    
    override func tearDown() {
        sut = nil
        mockStoreKit = nil
        super.tearDown()
    }
    
    // MARK: - Successful Purchase Tests
    
    func testPurchase_WithValidProduct_ReturnsSuccessResult() async throws {
        // Given
        let product = Product.mock(id: "premium")
        let expectedTransaction = Transaction.mock()
        mockStoreKit.purchaseResult = .success(.purchased(expectedTransaction))
        
        // When
        let result = try await sut.purchase(product: product)
        
        // Then
        guard case .purchased(let transaction) = result else {
            XCTFail("Expected purchased result")
            return
        }
        XCTAssertEqual(transaction.id, expectedTransaction.id)
    }
    
    // MARK: - Cancelled Purchase Tests
    
    func testPurchase_WhenUserCancels_ReturnsCancelledResult() async throws {
        // Given
        let product = Product.mock(id: "premium")
        mockStoreKit.purchaseResult = .success(.cancelled)
        
        // When
        let result = try await sut.purchase(product: product)
        
        // Then
        guard case .cancelled = result else {
            XCTFail("Expected cancelled result")
            return
        }
    }
    
    // MARK: - Error Handling Tests
    
    func testPurchase_WithNetworkError_ThrowsError() async {
        // Given
        let product = Product.mock(id: "premium")
        mockStoreKit.purchaseResult = .failure(.networkError)
        
        // When/Then
        do {
            _ = try await sut.purchase(product: product)
            XCTFail("Expected error to be thrown")
        } catch let error as FlareError {
            XCTAssertEqual(error, .networkError)
        } catch {
            XCTFail("Expected FlareError")
        }
    }
    
    // MARK: - Edge Cases
    
    func testPurchase_WithPendingTransaction_ReturnsPendingResult() async throws {
        // Given
        let product = Product.mock(id: "premium")
        mockStoreKit.purchaseResult = .success(.pending)
        
        // When
        let result = try await sut.purchase(product: product)
        
        // Then
        guard case .pending = result else {
            XCTFail("Expected pending result")
            return
        }
    }
}
```

**UI Testing (FlareUI):**
```swift
import XCTest
import SnapshotTesting
@testable import FlareUI

final class ProductViewSnapshotTests: XCTestCase {
    func testProductView_WithStandardProduct_MatchesSnapshot() {
        // Given
        let product = Product.mock(
            id: "premium",
            title: "Premium Subscription",
            price: "$9.99"
        )
        let view = ProductView(product: product)
        
        // When/Then
        assertSnapshot(matching: view, as: .image(layout: .device(config: .iPhone13)))
    }
    
    func testProductView_WithSubscription_ShowsSubscriptionDetails() {
        // Given
        let subscription = Product.mock(
            id: "monthly",
            title: "Monthly Subscription",
            price: "$4.99",
            subscriptionPeriod: .month
        )
        let view = ProductView(product: subscription)
        
        // When/Then
        assertSnapshot(matching: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
```

## Testing with StoreKit

### StoreKit Configuration File

Use a StoreKit configuration file for testing:

1. Create `Configuration.storekit` in your test target
2. Add test products, subscriptions, and offers
3. Configure in Xcode scheme for testing

### Testing Purchases

```swift
// Use sandbox testing for integration tests
// Configure test products in Configuration.storekit
func testRealPurchaseFlow() async throws {
    let productID = "test.premium.monthly"
    let products = try await Flare.shared.products(productIDs: [productID])
    
    guard let product = products.first else {
        XCTFail("Test product not found")
        return
    }
    
    let result = try await Flare.shared.purchase(product: product)
    // Verify purchase result
}
```

## Community

- **Discussions** - Join [GitHub Discussions](https://github.com/space-code/flare/discussions)
- **Issues** - Track [open issues](https://github.com/space-code/flare/issues)
- **Pull Requests** - Review [open PRs](https://github.com/space-code/flare/pulls)

## Recognition

Contributors are recognized in:
- GitHub contributors page
- Release notes
- Project README (for significant contributions)

## Questions?

- Check [existing issues](https://github.com/space-code/flare/issues)
- Search [discussions](https://github.com/space-code/flare/discussions)
- Ask in [Q&A discussions](https://github.com/space-code/flare/discussions/categories/q-a)
- Email the maintainer: nv3212@gmail.com

## Additional Resources

- [StoreKit Documentation](https://developer.apple.com/documentation/storekit)
- [StoreKit 2 Documentation](https://developer.apple.com/documentation/storekit/in-app_purchase)
- [In-App Purchase Best Practices](https://developer.apple.com/app-store/in-app-purchase/)
- [Testing In-App Purchases](https://developer.apple.com/documentation/xcode/setting-up-storekit-testing-in-xcode)

---

Thank you for contributing to Flare! 🎉

Your efforts help make in-app purchases easier for developers everywhere.