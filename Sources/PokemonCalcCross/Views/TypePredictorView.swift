import PokemonCore
import SwiftCrossUI

struct TypePredictorView: View {
    let typeKeys = PkmRawType.allCases.map { $0.rawValue }
    let typeKeysLocalized: [String: String]
    let localizedKeys: [String]
    let factorKeys = PokemonDamageFactor.allCases.map { $0.rawValue }
    let factorKeysLocalized: [String: String]
    let localizedFactorKeys: [String]
    @State private var selectedType: PkmRawType = .noType
    @State private var selectedFactor: PokemonDamageFactor = .normal
    @State private var vm = TypePredictorVm()

    init() {
        localizedKeys = typeKeys.map({ it in localized(it) })
        typeKeysLocalized = Dictionary(uniqueKeysWithValues: zip(localizedKeys, typeKeys))
        localizedFactorKeys = factorKeys.map({ it in localized(it) })
        factorKeysLocalized = Dictionary(uniqueKeysWithValues: zip(localizedFactorKeys, factorKeys))
    }

    var body: some View {
        VStack {
            Text(localized(TypePredictorConst.title))
                .font(.title)
                .padding()
                .padding(.bottom, 20)
            HStack(alignment: .center) {
                Text(localized(TypePredictorConst.damageReceived))
                Picker(
                    of: localizedKeys,
                    selection: Binding(
                        get: {
                            localized(selectedType.rawValue)
                        },
                        set: {
                            guard let key = $0 else {
                                selectedType = .noType
                                return
                            }
                            selectedType =
                                PkmRawType(
                                    rawValue: typeKeysLocalized[key] ?? "No Type")
                                ?? .noType
                        }
                    )
                )
                Picker(
                    of: localizedFactorKeys,
                    selection: Binding(
                        get: {
                            localized(selectedFactor.rawValue)
                        },
                        set: {
                            guard let key = $0 else {
                                selectedFactor = .normal
                                return
                            }
                            selectedFactor =
                                PokemonDamageFactor(
                                    rawValue: factorKeysLocalized[key] ?? "normal")
                                ?? .normal
                        }
                    )
                )
            }  // HStack
        }
    }
}
