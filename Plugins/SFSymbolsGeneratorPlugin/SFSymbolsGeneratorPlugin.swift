import PackagePlugin

@main struct MyPlugin: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        return []
    }

}
