// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-sfsymbols-generator",
    platforms: [.macOS(.v10_13)],
    products: [.plugin(name: "SFSymbolsGeneratorPlugin", targets: ["SFSymbolsGeneratorPlugin"])],
    dependencies: [.package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1")],
    targets: [
        .executableTarget(
            name: "SFSymbolsGenerator",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]
        ),
        .plugin(
            name: "SFSymbolsGeneratorPlugin",
            capability: .buildTool(),
            dependencies: [.target(name: "SFSymbolsGenerator")]
        ),
    ],
    swiftLanguageModes: [.v6]
)
