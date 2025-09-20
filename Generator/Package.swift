// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-sfsymbols-generator",
    platforms: [.macOS(.v13)],
    products: [.plugin(name: "SFSymbolsGeneratorPlugin", targets: ["SFSymbolsGeneratorPlugin"])],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.6.1"),
        .package(url: "https://github.com/apple/swift-collections", exact: "1.2.1"),
    ],
    targets: [
        .executableTarget(
            name: "SFSymbolsGenerator",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "OrderedCollections", package: "swift-collections"),
            ]
        ),
        .plugin(
            name: "SFSymbolsGeneratorPlugin",
            capability: .buildTool(),
            dependencies: [.target(name: "SFSymbolsGenerator")]
        ),
    ],
    swiftLanguageModes: [.v6]
)
