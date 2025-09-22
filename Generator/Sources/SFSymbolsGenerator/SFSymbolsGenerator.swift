import Foundation
import ArgumentParser

@main struct SFSymbolsGenerator: ParsableCommand {

    @Argument(help: "The path to the package directory", completion: .directory) var path: String

    func run() throws {
        let pipe = Pipe()
        let process = Process()
        process.arguments = [path]
        process.executableURL = Bundle.module.url(forResource: "generator", withExtension: "py")
        process.standardOutput = pipe
        process.waitUntilExit()

        print("!!!!!!!!!! Generation Finished !!!!!!!!!!")
        if #available(macOS 10.15.4, *) {
            try pipe.fileHandleForReading.readToEnd().map {
                print(String(data: $0, encoding: .utf8))
            }
        } else {
            print(String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8))
        }
        print(process.terminationStatus)
        if process.terminationStatus != 0 {
            print("!!!!!!!!!! Generation Failed !!!!!!!!!!")
            throw Error.generationFailed
        }
    }

    enum Error: Swift.Error {
        case generationFailed
    }

}
