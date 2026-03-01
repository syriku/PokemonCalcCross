/// Represents the complete type effectiveness result for a Pokémon.
///
/// When created with a single type, `pkmType.1` is set to `.noType` and only
/// single-type effectiveness is calculated.
/// When created with two types, both `defenseSide` and `attackSide` reflect
/// dual-type interactions.
public struct TypeEffectiveness {
    public let pkmType: (PkmRawType, PkmRawType)
    public let defenseSide: EffectivenessDefenseSide
    public let attackSide: EffectivenessAttackSide

    public init(_ type1: PkmRawType) {
        self.pkmType = (type1, .noType)
        self.defenseSide = EffectivenessDefenseSide(type1)
        self.attackSide = EffectivenessAttackSide(type1)
    }

    public init(type1: PkmRawType, type2: PkmRawType) {
        if type1 == .noType && type2 != .noType {
            self.pkmType = (type2, .noType)
        } else {
            self.pkmType = (type1, type2)
        }

        self.defenseSide = EffectivenessDefenseSide(type1: type1, type2: type2)
        self.attackSide = EffectivenessAttackSide(type1: type1, type2: type2)
    }
}

/// Describes how much damage a defending Pokémon **receives** from each attacking type.
///
/// Each array contains the attacking types that produce the listed damage multiplier
/// against this Pokémon's type combination.
public struct EffectivenessDefenseSide {
    public let quadrupleDamageFrom: [PkmRawType]
    public let doubleDamageFrom: [PkmRawType]
    public let halfDamageFrom: [PkmRawType]
    public let quarterDamageFrom: [PkmRawType]
    public let noDamageFrom: [PkmRawType]

    /// Builds the defensive breakdown for a **single** defending type.
    ///
    /// Iterates over every attacking type (excluding `.noType`) and reads the
    /// effectiveness factor from `typeEffectivenessRawByDefensive`, then groups
    /// the attacking types by their resulting multiplier.
    init(_ type1: PkmRawType) {
        let factors = typeEffectivenessRawByDefensive(type1)

        var quadruple: [PkmRawType] = []
        var double: [PkmRawType] = []
        var half: [PkmRawType] = []
        var quarter: [PkmRawType] = []
        var none: [PkmRawType] = []

        for (index, factor) in factors.enumerated() {
            let attackingType = PkmRawType(index: index)
            guard attackingType != .noType else { continue }

            switch factor {
            case 4.0: quadruple.append(attackingType)
            case 2.0: double.append(attackingType)
            case 0.5: half.append(attackingType)
            case 0.25: quarter.append(attackingType)
            case 0.0: none.append(attackingType)
            default: break
            }
        }

        self.quadrupleDamageFrom = quadruple
        self.doubleDamageFrom = double
        self.halfDamageFrom = half
        self.quarterDamageFrom = quarter
        self.noDamageFrom = none
    }

    init(type1: PkmRawType, type2: PkmRawType) {
        let factors1 = typeEffectivenessRawByDefensive(type1)
        let factors2 = typeEffectivenessRawByDefensive(type2)

        var quadruple: [PkmRawType] = []
        var double: [PkmRawType] = []
        var half: [PkmRawType] = []
        var quarter: [PkmRawType] = []
        var none: [PkmRawType] = []

        for index in 0..<factors1.count {
            let attackingType = PkmRawType(index: index)
            guard attackingType != .noType else { continue }

            let combinedFactor = factors1[index] * factors2[index]

            switch combinedFactor {
            case 4.0: quadruple.append(attackingType)
            case 2.0: double.append(attackingType)
            case 0.5: half.append(attackingType)
            case 0.25: quarter.append(attackingType)
            case 0.0: none.append(attackingType)
            default: break
            }
        }

        self.quadrupleDamageFrom = quadruple
        self.doubleDamageFrom = double
        self.halfDamageFrom = half
        self.quarterDamageFrom = quarter
        self.noDamageFrom = none
    }
}

/// Describes how much damage an attacking Pokémon **deals** to each defending type.
///
/// Each array contains the defending types that receive the listed damage multiplier
/// from this Pokémon's type combination.
public struct EffectivenessAttackSide {
    public let quadrupleDamageTo: [PkmRawType]
    public let doubleDamageTo: [PkmRawType]
    public let halfDamageTo: [PkmRawType]
    public let quarterDamageTo: [PkmRawType]
    public let noDamageTo: [PkmRawType]

    /// Builds the offensive breakdown for a **single** attacking type.
    ///
    /// Iterates over every defending type (excluding `.noType`) and reads the
    /// effectiveness factor from `typeEffectivenessByOffensive`, then groups
    /// the defending types by their resulting multiplier.
    init(_ type1: PkmRawType) {
        let factors = typeEffectivenessByOffensive(type1)

        var quadruple: [PkmRawType] = []
        var double: [PkmRawType] = []
        var half: [PkmRawType] = []
        var quarter: [PkmRawType] = []
        var none: [PkmRawType] = []

        for (index, factor) in factors.enumerated() {
            let defendingType = PkmRawType(index: index)
            guard defendingType != .noType else { continue }

            switch factor {
            case 4.0: quadruple.append(defendingType)
            case 2.0: double.append(defendingType)
            case 0.5: half.append(defendingType)
            case 0.25: quarter.append(defendingType)
            case 0.0: none.append(defendingType)
            default: break
            }
        }

        self.quadrupleDamageTo = quadruple
        self.doubleDamageTo = double
        self.halfDamageTo = half
        self.quarterDamageTo = quarter
        self.noDamageTo = none
    }

    init(type1: PkmRawType, type2: PkmRawType) {
        let factors1 = typeEffectivenessByOffensive(type1)
        let factors2 = typeEffectivenessByOffensive(type2)

        var quadruple: [PkmRawType] = []
        var double: [PkmRawType] = []
        var half: [PkmRawType] = []
        var quarter: [PkmRawType] = []
        var none: [PkmRawType] = []

        for index in 0..<factors1.count {
            let defendingType = PkmRawType(index: index)
            guard defendingType != .noType else { continue }

            let combinedFactor = max(factors1[index], factors2[index])  // Offensive multipliers stack by taking the maximum

            switch combinedFactor {
            case 4.0: quadruple.append(defendingType)
            case 2.0: double.append(defendingType)
            case 0.5: half.append(defendingType)
            case 0.25: quarter.append(defendingType)
            case 0.0: none.append(defendingType)
            default: break
            }
        }

        self.quadrupleDamageTo = quadruple
        self.doubleDamageTo = double
        self.halfDamageTo = half
        self.quarterDamageTo = quarter
        self.noDamageTo = none
    }
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
