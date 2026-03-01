import Foundation
import SwiftCrossUI

struct TypeCalculatorView: View {
    let typeKeys = PkmType.allCases.map { $0.rawValue }
    let typeKeysLocalized: [String: String]
    let localizedKeys: [String]
    let vm: TypeCalculatorVm = TypeCalculatorVm()

    init() {
        localizedKeys = typeKeys.map({ it in localized(it) })
        typeKeysLocalized = Dictionary(uniqueKeysWithValues: zip(localizedKeys, typeKeys))
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
                                localized(vm.selectedType1.rawValue)
                            },
                            set: {
                                guard let key = $0 else {
                                    vm.selectedType1 = .noType
                                    return
                                }
                                vm.selectedType1 =
                                    PkmType(
                                        rawValue: typeKeysLocalized[key] ?? "No Type") ?? .noType
                            }
                        )
                    )
                    .padding(.bottom, 5)
                    // second type
                    Picker(
                        of: localizedKeys,
                        selection: Binding(
                            get: {
                                localized(vm.selectedType2.rawValue)
                            },
                            set: {
                                guard let key = $0 else {
                                    vm.selectedType2 = .noType
                                    return
                                }
                                vm.selectedType2 =
                                    PkmType(
                                        rawValue: typeKeysLocalized[key] ?? "No Type") ?? .noType
                            }
                        ))
                }

                // action

                // result
            }
        }
    }
}
