public struct PokemonType: Hashable {
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

    static func allComb() -> Set<Self> {
        var allTypes = Set<Self>()
        for i in 1..<PkmRawType.allCases.count {
            for j in i..<PkmRawType.allCases.count {
                let type1 = PkmRawType.allCases[i]
                if i == j {
                    allTypes.insert(Self(type1: type1, type2: .noType))
                    continue
                }
                let type2 = PkmRawType.allCases[j]
                allTypes.insert(Self(type1: type1, type2: type2))
            }
        }
        return allTypes
    }
}
