public enum PokemonDamageFactor: String, CaseIterable {
    case quadruple
    case double
    case normal
    case half
    case quarter
    case none

    var multiplier: Double {
        switch self {
        case .normal: return 1.0
        case .double: return 2.0
        case .quadruple: return 4.0
        case .half: return 0.5
        case .quarter: return 0.25
        case .none: return 0.0
        }
    }

    var isWeakness: Bool {
        switch self {
        case .double, .quadruple: return true
        default: return false
        }
    }

    var isResistance: Bool {
        switch self {
        case .half, .quarter: return true
        default: return false
        }
    }
}
