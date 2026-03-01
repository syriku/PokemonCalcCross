import PokemonCore
import SwiftCrossUI

class TypeCalculatorVm: ObservableObject {
    @Published var selectedType1: PkmRawType = .noType {
        didSet {
            typeEffectiveness = nil
        }
    }
    @Published var selectedType2: PkmRawType = .noType {
        didSet {
            typeEffectiveness = nil
        }
    }
    @Published var typeEffectiveness: TypeEffectiveness? = nil
}
