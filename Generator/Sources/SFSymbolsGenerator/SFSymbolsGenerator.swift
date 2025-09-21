import Foundation
import ArgumentParser

@main struct SFSymbolsGenerator: ParsableCommand {

    @Argument(help: "The path to the package directory", completion: .directory) var path: String

    func run() throws {
        let process = Process()
        process.arguments = [path]
        process.executableURL = Bundle.module.url(forResource: "generator", withExtension: "py")
        process.waitUntilExit()
    }

}
