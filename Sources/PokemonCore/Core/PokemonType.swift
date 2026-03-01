public struct PokemonType {
    public let type1: PkmRawType
    public let type2: PkmRawType

    public init(_ single: PkmRawType) {
        self.type1 = single
        self.type2 = .noType
    }

    public init(type1: PkmRawType, type2: PkmRawType) {
        self.type1 = type1
        self.type2 = type2
    }
}
