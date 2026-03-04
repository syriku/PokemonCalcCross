import Observation

/// Used to predict possible Pokémon type combinations based on known type effectiveness information.
///
/// - Warning: Initialization and computation of this type are expensive operations,
///   as they require iterating through all possible type combinations.
///   It is recommended to perform these operations on a background thread to avoid blocking the main thread.
@Observable
public class EffectivenessPredict {
    @ObservationIgnored var candidatesEffectiveness: [PokemonType: TypeEffectiveness]
    public var candidates: [(PokemonType)] {
        candidatesEffectiveness.keys.map { $0 }
    }

    @ObservationIgnored var effectiveness: [PkmRawType: PokemonDamageFactor] = [:]

    public init() {
        let allTypes = PokemonType.allComb()
        candidatesEffectiveness = [:]
        for type in allTypes {
            candidatesEffectiveness[type] = TypeEffectiveness(type1: type.type1, type2: type.type2)
        }
    }

    public func addEffectiveness(type: PkmRawType, factor: PokemonDamageFactor) {
        effectiveness[type] = factor
        calcNewCandidates(type: type, factor: factor)
    }

    private func calcNewCandidates(type: PkmRawType, factor: PokemonDamageFactor) {
        var toRemove: [PokemonType] = []
        switch factor {
        case .double, .quadruple:
            for candidate in candidatesEffectiveness {
                if !candidate.value.defenseSide.doubleDamageFrom.contains(type)
                    && !candidate.value.defenseSide.quadrupleDamageFrom.contains(type)
                {
                    toRemove.append(candidate.key)
                }
            }
        case .half, .quarter:
            for candidate in candidatesEffectiveness {
                if !candidate.value.defenseSide.halfDamageFrom.contains(type)
                    && !candidate.value.defenseSide.quarterDamageFrom.contains(type)
                {
                    toRemove.append(candidate.key)
                }
            }
        case .none:
            for candidate in candidatesEffectiveness {
                if !candidate.value.defenseSide.noDamageFrom.contains(type) {
                    toRemove.append(candidate.key)
                }
            }
        case .normal:
            for candidate in candidatesEffectiveness {
                if candidate.value.defenseSide.doubleDamageFrom.contains(type)
                    || candidate.value.defenseSide.quadrupleDamageFrom.contains(type)
                    || candidate.value.defenseSide.halfDamageFrom.contains(type)
                    || candidate.value.defenseSide.quarterDamageFrom.contains(type)
                    || candidate.value.defenseSide.noDamageFrom.contains(type)
                {
                    toRemove.append(candidate.key)
                }
            }
        }
        for type in toRemove {
            candidatesEffectiveness.removeValue(forKey: type)
        }
    }
}
