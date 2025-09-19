// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-sfsymbols",
    products: [.library(name: "SFSymbols", targets: ["SFSymbols"])],
    dependencies: [.package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1")],
    targets: [
        .executableTarget(
            name: "SFSymbolsGenerator",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]
        ),
        .target(name: "SFSymbols"),
        .testTarget(name: "SFSymbolsTests", dependencies: ["SFSymbols"]),
        .plugin(
            name: "SFSymbolsGeneratorPlugin",
            capability: .buildTool()
        ),
    ],
    swiftLanguageModes: [.v6]
)
