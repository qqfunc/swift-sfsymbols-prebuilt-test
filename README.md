# Prebuilt Binaries of Swift SFSymbols

This project uses Python to generate `SFSymbol` definitions. This is because Swift's
[PropertyListDecoder](https://developer.apple.com/documentation/foundation/propertylistdecoder)
cannot maintain the order of dictionaries.
