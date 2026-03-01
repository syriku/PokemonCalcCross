import Foundation

/// This is the complete list of Pokémon types.
/// Except for `noType`, entries follow the order from the 52poke (wiki) type chart.
public enum PkmRawType: String, CaseIterable {
    case noType = "No Type"
    case normal = "Normal"
    case fighting = "Fighting"
    case flying = "Flying"
    case poison = "Poison"
    case ground = "Ground"
    case rock = "Rock"
    case bug = "Bug"
    case ghost = "Ghost"
    case steel = "Steel"
    case fire = "Fire"
    case water = "Water"
    case grass = "Grass"
    case electric = "Electric"
    case psychic = "Psychic"
    case ice = "Ice"
    case dragon = "Dragon"
    case dark = "Dark"
    case fairy = "Fairy"

    /// Zero-based index of the case in the `allCases` array.
    /// This includes `noType` as the first element (index 0).
    public var index: Int {
        return Self.allCases.firstIndex(of: self) ?? -1
    }

    /// Initialize a `PkmType` from a zero-based index into `allCases`.
    /// Returns `nil` if the index is out of range.
    public init(index: Int) {
        guard index >= 0 && index < Self.allCases.count else {
            self = .noType
            return
        }
        self = Self.allCases[index]
    }
}
