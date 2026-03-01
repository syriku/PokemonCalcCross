public struct TypeEffectiveness {
    public let pokemonType: PokemonType
    public let defenseSide: EffectivenessDefenseSide?
    public let attackSide: EffectivenessAttackSide?

    public init(_ type1: PkmRawType, detailMode: Bool = false) {
        self.pokemonType = PokemonType(type1)
        self.defenseSide = nil
        self.attackSide = nil
    }
}

public struct EffectivenessDefenseSide {
    public let quadrupleDamageFrom: [PokemonType]
    public let doubleDamageFrom: [PokemonType]
    public let halfDamageFrom: [PokemonType]
    public let quarterDamageFrom: [PokemonType]
    public let noDamageFrom: [PokemonType]
}

public struct EffectivenessAttackSide {
    public let quadrupleDamageTo: [PokemonType]
    public let doubleDamageTo: [PokemonType]
    public let halfDamageTo: [PokemonType]
    public let quarterDamageTo: [PokemonType]
    public let noDamageTo: [PokemonType]
}

struct TypeEffectivenessFactor {
    let defenseSide: [Double]
    let attackSide: [Double]
}

/// Returns defensive effectiveness factors for a *single defensive type*.
///
/// Order of returned factors (attacking types):
/// `[No Type, Normal, Fighting, Flying, Poison, Ground, Rock, Bug, Ghost, Steel, Fire, Water, Grass, Electric, Psychic, Ice, Dragon, Dark, Fairy]`
///
/// Notes:
/// - The first element is always `1.0` for `.noType`.
/// - Values follow the standard Pokémon type chart (Gen 6+), using multipliers: `0, 0.5, 1, 2`.
func typeEffectivenessRawByDefensive(_ pkmType: PkmRawType) -> [Double] {
    return rawTypeEffectivenessData[pkmType.index]
}

/// Returns offensive effectiveness factors for a *single attacking type*.
///
/// Order of returned factors (defending types):
/// `[No Type, Normal, Fighting, Flying, Poison, Ground, Rock, Bug, Ghost, Steel, Fire, Water, Grass, Electric, Psychic, Ice, Dragon, Dark, Fairy]`
///
/// Notes:
/// - The first element is always `1.0` for `.noType`.
/// - Values follow the standard Pokémon type chart (Gen 6+), using multipliers: `0, 0.5, 1, 2`.
func typeEffectivenessByOffensive(_ pkmType: PkmRawType) -> [Double] {

    if pkmType == .noType {
        return [Double](repeating: 1.0, count: 19)
    }

    let attackTypeIndex = pkmType.index

    return rawTypeEffectivenessData.map { $0[attackTypeIndex] }
}
