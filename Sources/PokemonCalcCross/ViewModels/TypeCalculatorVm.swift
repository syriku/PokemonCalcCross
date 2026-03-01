import Foundation
import Observation
import PokemonCore

@Observable
class TypeCalculatorVm {
    var selectedType1: PkmRawType = .noType
    var selectedType2: PkmRawType = .noType
}
