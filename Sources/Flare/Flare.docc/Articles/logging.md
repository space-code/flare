# Logging

Learn how to log important events.

## Overview

The `Flare` supports logging out of the box. It has a set of methods to facilitate logging, each accompanied by a detailed description.

### Enabling Logging

> important: `Flare` uses the `log` package for logging functionality. See [Log Package](https://github.com/space-code/log) for more info.

By default, `Flare` logs only `debug` or `info` events based on the package building scheme. The special logging level can be forced by setting ``IFlare/logLevel`` to Flare.

```swift
Flare.shared.logLevel = .all
```

The logging can be turned off by setting ``IFlare/logLevel`` to `off`.
