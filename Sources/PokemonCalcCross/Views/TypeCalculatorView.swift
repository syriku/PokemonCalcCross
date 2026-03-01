import Foundation
import SwiftCrossUI

struct TypeCalculatorView: View {
    let typeKeys = PkmType.allCases.map { $0.rawValue }
    let typeKeysLocalized: [String: String]
    let localizedKeys: [String]
    @State var selectedType1Key: PkmType?
    @State var selectedType2Key: PkmType?

    init() {
        localizedKeys = typeKeys.map({ it in localized(it) })
        typeKeysLocalized = Dictionary(uniqueKeysWithValues: zip(localizedKeys, typeKeys))

        selectedType1Key = .noType
        selectedType2Key = .noType
    }

    var body: some View {
        VStack {
            Text(localized(typeCalculatorTitle))
                .font(.title)
                .padding()
                .padding(.bottom, 20)

            HStack {
                // pick
                VStack {
                    // first type
                    Picker(
                        of: localizedKeys,
                        selection: Binding(
                            get: {
                                localized(selectedType1Key!.rawValue)
                            },
                            set: {
                                selectedType1Key = PkmType(
                                    rawValue: typeKeysLocalized[$0!] ?? "No Type")
                            }
                        )
                    )
                    .padding(.bottom, 5)
                    // second type
                    Picker(
                        of: localizedKeys,
                        selection: Binding(
                            get: {
                                localized(selectedType2Key!.rawValue)
                            },
                            set: {
                                selectedType2Key = PkmType(
                                    rawValue: typeKeysLocalized[$0!] ?? "No Type")
                            }
                        ))
                }

                // action

                // result
            }
        }
    }
}
