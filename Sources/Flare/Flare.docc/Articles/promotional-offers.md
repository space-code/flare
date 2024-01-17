# Promotional Offers

Learn how to use promotional offers.

## Overview

[Promotional offers](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/implementing_promotional_offers_in_your_app) can be effective in winning back lapsed subscribers or retaining current subscribers. You can provide lapsed or current subscribers a limited-time offer of a discounted or free period of service for auto-renewable subscriptions on macOS, iOS, and tvOS.

[Introductory offers](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/implementing_introductory_offers_in_your_app#2940726) can offer a discounted introductory price, including a free trial, to eligible users. You can make introductory offers to customers who haven’t previously received an introductory offer for the given product, or for any products in the same subscription group.

> note: To implement the offers, first complete the setup on App Store Connect, including generating a private key. See [Setting up promotional offers](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/setting_up_promotional_offers) for more details.

## Introductory Offers

> important: Do not show a subscription offer to users if they are not eligible for it. It’s very important to check this beforehand.

First, check if the user is eligible for an introductory offer.

> tip For this purpose can be used ``IFlare/checkEligibility(productIDs:)`` method. This method requires iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0. Otherwise, see [Determine Eligibility](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/implementing_introductory_offers_in_your_app#2940726). 

```swift
func isEligibleForIntroductoryOffer(productID: String) async -> Bool {
    let dict = await Flare.shared.checkEligibility(productIDs: [productID])
    return dict[productID] == .eligible
}
```

Second, proceed with the purchase as usual. See [Perform Purchase](<doc:perform-purchase>)

## Promotional Offers

First, you need to fetch the signature from your server. See [Generation a signature for promotional offers](https://developer.apple.com/documentation/storekit/in-app_purchase/original_api_for_in-app_purchase/subscriptions_and_offers/generating_a_signature_for_promotional_offers) for more information.

Second, configure ``IFlare`` with a ``Configuration``.

```swift
Flare.configure(configuration: Configuration(applicationUsername: "username"))
```

Third, request a signature from your server and prepare the discount offer.

```swift
func prepareOffer(username: String, productID: String, offerID: String, completion: @escaping (PromotionalOffer.SignedData) -> Void) {
    YourServer.fetchOfferDetails(
                username: username,
                productIdentifier: productID,
                offerIdentifier: offerID,
                completion: { (nonce: UUID, timestamp: NSNumber, keyIdentifier: String, signature: String) in
        let signedData = PromotionalOffer.SignedData(
            identifier: offerID,
            keyIdentifier: keyIdentifier,
            nonce: nonce,
            signature: signature,
            timestamp: timestamp
        )

        completion(signedData)
    }
}
```

Fourth, complete the purchase with the promotional offer.

```swift
func purchase(product: StoreProduct, discount: StoreProductDiscount, signedData: SignedData) {
    let promotionalOffer = PromotionalOffer(discount: discount, signedData: signedData)

    Flare.default.purchase(product: product, promotionalOffer: promotionalOffer) { result in
        switch result {
        case let .success(transaction):
            break
        case let .failure(error):
            break
        }
    }

    // Or using async/await
    let transaction = Flare.shared.purchase(product: product, promotionalOffer: promotionalOffer)
}
```

Fifth, complete the transaction.

```swift
Flare.default.finish(transaction: transaction)
```
