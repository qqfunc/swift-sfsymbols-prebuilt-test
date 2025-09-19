// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-sfsymbols",
    products: [.library(name: "SFSymbols", targets: ["SFSymbols"])],
    targets: [
        .target(name: "SFSymbols"),
        .testTarget(name: "SFSymbolsTests", dependencies: ["SFSymbols"]),
    ],
    swiftLanguageModes: [.v6]
)
