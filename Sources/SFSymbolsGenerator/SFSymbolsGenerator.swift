import Foundation
import ArgumentParser

@available(macOS 13.0, *) @main struct SFSymbolsGenerator: ParsableCommand {

    @Argument(help: "The path to the package directory", completion: .directory) var path: String

    func run() throws {
        var url =
            if #available(macOS 13.0, *) {
                URL(filePath: path, directoryHint: .isDirectory)
            } else {
                URL(fileURLWithPath: path, isDirectory: true)
            }
        url.append(path: "SFSymbol+Symbols.swift")

        let string = """
            public extension SFSymbol {
                static let circle = SFSymbol(name: "circle")
                static let `square.fill` = SFSymbol(name: "square.fill")
            }
            """
        try string.write(to: url, atomically: false, encoding: .utf8)
    }

}
