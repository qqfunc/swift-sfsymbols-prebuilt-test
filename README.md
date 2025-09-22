# Swift SFSymbols Artifacts

[![Build](https://github.com/qqfunc/swift-sfsymbols-prebuilt-test/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/qqfunc/swift-sfsymbols-prebuilt-test/actions/workflows/build.yml)

This project uses Python to generate `SFSymbol` definitions. This is because Swift's
[PropertyListDecoder](https://developer.apple.com/documentation/foundation/propertylistdecoder)
cannot maintain the order of dictionaries.
