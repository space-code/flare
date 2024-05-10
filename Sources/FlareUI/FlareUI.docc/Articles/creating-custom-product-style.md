# Creating a Custom Product Style

Learn how to create a custom style for a product.

## Custom Product Style

The `FlareUI` provides a simple way to customize the appearance of the products. For this, you need to implement an object that conforms to ``IProductStyle`` and pass it to ``SwiftUI/View/productViewStyle(_:)`` or ``SwiftUI/View/productViewStyle(_:)``.

> note: You can use one of the predefined styles that are optimized for various platforms: ``LargeProductStyle`` and ``CompactProductStyle``.

Based on the ``ProductStyleConfiguration/State-swift.enum`` enum, you can define different views to display for various states.

```swift
struct CustomProductStyle: IProductStyle {
    func makeBody(configuration: Configuration) -> some View {
        switch configuration.state {
        case .loading:
            // Provide a custom loader view
        case let .product(product):
            // Provide a custom view that displays the product's info
        case let .error(error):
            // Provide a view for displaying an error to a user.
        }
    }
}
```

## Custom Subscription Control Style

To create a custom subscription style create an object that conforms to ``ISubscriptionControlStyle``.

```swift
struct CustomSubscriptionStyle: ISubscriptionControlStyle {
    func makeBody(configuration: SubscriptionStoreControlStyleConfiguration) -> some View {
        VStack {
            configuration.label
                .font(.title)
            configuration.description
                .font(.body)
            configuration.price
                .font(.body)
                .foregroundColor(.blue)
            
            // If you need to ttack a selected state
            // configuration.isSelected

            // If the subscription is active
            // configuration.isActive
            
            // Triggers a purchase action
            // configuration.trigger()
        }
    }
}
```

Then, we use can apply the custom style to ``SubscriptionsView/subscriptionControlStyle(_:)`` or ``SubscriptionsViewController/subscriptionControlStyle``.
