import PackagePlugin

@main struct MyPlugin: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        return [
            .buildCommand(
                displayName: "Generate SFSymbols Package File",
                executable: try context.tool(named: "SFSymbolsGenerator").url,
                arguments: [context.pluginWorkDirectoryURL.path()],
                environment: [:],
                inputFiles: [],
                outputFiles: [context.pluginWorkDirectoryURL.appending(path: "SFSymbol+Symbols.swift")]
            )
        ]
    }

}
