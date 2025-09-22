// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-sfsymbols-artifacts",
    products: [.library(name: "SFSymbols", targets: ["SFSymbols"])],
    dependencies: [
        .package(path: "Generator"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1"),
    ],
    targets: [
        .target(name: "SFSymbols", plugins: [.plugin(name: "SFSymbolsGeneratorPlugin", package: "Generator")]),
        .testTarget(name: "SFSymbolsTests", dependencies: [.target(name: "SFSymbols")]),
    ],
    swiftLanguageModes: [.v6]
)
