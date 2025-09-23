# Swift SFSymbols Artifacts

[![Build](https://github.com/qqfunc/swift-sfsymbols-prebuilt-test/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/qqfunc/swift-sfsymbols-prebuilt-test/actions/workflows/build.yml)

Prebuilt binary artifacts for the Swift SFSymbols package.

## Build Dependencies

### SF Symbols

Retrieving symbol data requires the [SF Symbols](https://developer.apple.com/sf-symbols/) app.

### Python

This project uses Python 3.12 or later to generate `SFSymbol` definitions. This is because Swift's
[`PropertyListDecoder`](https://developer.apple.com/documentation/foundation/propertylistdecoder)
cannot maintain the order of dictionaries.
