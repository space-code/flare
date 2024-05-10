# Caching Products

Learn how to cache products.

## Overview

Caching products can improve the performance and user experience of your app by reducing the need to fetch product information from the App Store. In this guide, we'll explore how to cache products efficiently in your app.

## Implementing Product Caching

By default, Flare uses cached data if available; otherwise, it fetches the products. If you want to change this behavior, you need to configure Flare with a custom caching policy. For this, Flare provides two options ``FetchCachePolicy/fetch`` and ``FetchCachePolicy/cachedOrFetch``.

You can override the default behaviour passing a ``FetchCachePolicy/fetch`` with a configuration.

```swift
Flare.default.configure(with: .init(Configuration(username: "username", fetchCachePolicy: .fetch)))
```

This configuration tells Flare to always fetch the latest data, ignoring any cached data. You can adjust this behavior as needed for your app.
