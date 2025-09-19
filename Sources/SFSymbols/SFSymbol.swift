/// A type that represents SFSymbols.
///
/// ```swift
/// print(SFSymbol.circle.name)  // circle
/// print(SFSymbol.`square.fill`.name)  // square.fill
/// ```
public struct SFSymbol {

    init(name: String) { self.name = name }

    /// The name of the symbol.
    public let name: String

}

extension SFSymbol: Hashable {}

extension SFSymbol: Codable {}

extension SFSymbol: Sendable {}
