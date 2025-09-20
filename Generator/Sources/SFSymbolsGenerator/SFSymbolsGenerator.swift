/* import Foundation
import ArgumentParser

@main struct SFSymbolsGenerator: ParsableCommand {

    @Argument(help: "The path to the package directory", completion: .directory) var path: String

    let nameAvailabilityPath =
        "/Applications/SF Symbols.app/Contents/Resources/Metadata/name_availability.plist"

    mutating func run() throws {
        var url = URL(filePath: path, directoryHint: .isDirectory)
        url.append(path: "SFSymbol+Symbols.swift")

        let string = """
            public extension SFSymbol {
                static let circle = SFSymbol(name: "circle")
                static let `square.fill` = SFSymbol(name: "square.fill")
            }
            """
        // try string.write(to: url, atomically: false, encoding: .utf8)

        let nameAvailability = try loadNameAvailability()
        generateAvailabilities(with: nameAvailability)
        availabilities.forEach { print($1) }
    }

    func loadNameAvailability() throws -> SFSymbolsNameAvailability {
        let data = try Data(contentsOf: URL(filePath: nameAvailabilityPath))
        return try PropertyListDecoder().decode(SFSymbolsNameAvailability.self, from: data)
    }

    mutating func generateAvailabilities(with nameAvailability: SFSymbolsNameAvailability) {
        nameAvailability.yearToRelease.forEach {
            availabilities[$0] =
                "@available (\($1.map { "\($0) \($1)" }.joined(separator: ", ")), *)"
        }
    }

    var availabilities: [String: String] = [:]

} */
