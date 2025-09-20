// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-sfsymbols-prebuilt",
    products: [.library(name: "SFSymbols", targets: ["SFSymbols"])],
    dependencies: [.package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1")],
    targets: [
        .executableTarget(
            name: "SFSymbolsGenerator",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]
        ),
        .target(name: "SFSymbols", plugins: [.plugin(name: "SFSymbolsGeneratorPlugin")]),
        .testTarget(name: "SFSymbolsTests", dependencies: [.target(name: "SFSymbols")]),
        .plugin(
            name: "SFSymbolsGeneratorPlugin",
            capability: .buildTool(),
            dependencies: [.target(name: "SFSymbolsGenerator")]
        ),
    ],
    swiftLanguageModes: [.v6]
)
