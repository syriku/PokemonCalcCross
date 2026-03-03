import PokemonCore
import SwiftCrossUI

struct TypePredictorView: View {
    let typeKeys = PkmRawType.allCases.map { $0.rawValue }
    let typeKeysLocalized: [String: String]
    let localizedKeys: [String]
    @State private var selectedType: PkmRawType = .noType

    init() {
        localizedKeys = typeKeys.map({ it in localized(it) })
        typeKeysLocalized = Dictionary(uniqueKeysWithValues: zip(localizedKeys, typeKeys))
    }

    var body: some View {
        VStack {
            Text(localized(TypePredictorConst.title))
                .font(.title)
                .padding()
                .padding(.bottom, 20)
            HStack {
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
            }
        }
    }
}
