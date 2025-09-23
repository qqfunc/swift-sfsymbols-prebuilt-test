// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-sfsymbols-artifacts",
    products: [.library(name: "SFSymbols", targets: ["SFSymbols"])],
    dependencies: [.package(path: "Generator")],
    targets: [
        .target(
            name: "SFSymbols",
            plugins: [.plugin(name: "SFSymbolsGeneratorPlugin", package: "Generator")]
        ),
        .testTarget(name: "SFSymbolsTests", dependencies: [.target(name: "SFSymbols")]),
    ],
    swiftLanguageModes: [.v6]
)
