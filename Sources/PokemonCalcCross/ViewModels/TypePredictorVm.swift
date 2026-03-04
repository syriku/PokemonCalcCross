import Observation
import PokemonCore
import SwiftCrossUI

class TypePredictorVm: ObservableObject {
    let typePredict = EffectivenessPredict()
    @Published var candidates = [PokemonType]()

    init() {
        listenToRepublish()
    }

    func addEffectiveness(type: PkmRawType, factor: PokemonDamageFactor) {
        typePredict.addEffectiveness(type: type, factor: factor)
    }

    private func listenToRepublish() {
        self.candidates = typePredict.candidates
        withObservationTracking(
            {
                _ = typePredict.candidates
            },
            onChange: { [weak self] in
                guard let self = self else { return }
                Task {
                    await MainActor.run {
                        self.listenToRepublish()
                    }
                }
            })
    }
}
