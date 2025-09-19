import Testing
@testable import SFSymbols

@Test func testSymbolNames() async throws {
    #expect(SFSymbol.circle.name == "circle")
    #expect(SFSymbol.`square.fill`.name == "square.fill")
}
