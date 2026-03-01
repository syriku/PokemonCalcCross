import Foundation
import PokemonCore
import SwiftCrossUI

struct TypeCalculatorView: View {
    let typeKeys = PkmRawType.allCases.map { $0.rawValue }
    let typeKeysLocalized: [String: String]
    let localizedKeys: [String]
    @State var vm: TypeCalculatorVm = TypeCalculatorVm()

    init() {
        localizedKeys = typeKeys.map({ it in localized(it) })
        typeKeysLocalized = Dictionary(uniqueKeysWithValues: zip(localizedKeys, typeKeys))
    }

    var effectivenessDefenseSideData: [[PkmRawType]] {
        [
            vm.typeEffectiveness?.defenseSide.quadrupleDamageFrom ?? [],
            vm.typeEffectiveness?.defenseSide.doubleDamageFrom ?? [],
            vm.typeEffectiveness?.defenseSide.halfDamageFrom ?? [],
            vm.typeEffectiveness?.defenseSide.quarterDamageFrom ?? [],
            vm.typeEffectiveness?.defenseSide.noDamageFrom ?? [],
        ]
    }

    var effectivenessOffenseSideData: [[PkmRawType]] {
        [
            vm.typeEffectiveness?.offenseSide.quadrupleDamageTo ?? [],
            vm.typeEffectiveness?.offenseSide.doubleDamageTo ?? [],
            vm.typeEffectiveness?.offenseSide.halfDamageTo ?? [],
            vm.typeEffectiveness?.offenseSide.quarterDamageTo ?? [],
            vm.typeEffectiveness?.offenseSide.noDamageTo ?? [],
        ]
    }

    struct EffectivenessRow: Identifiable {
        let id = UUID()
        let multiplier: String
        let defense: String
        let offense: String
    }

    private func formatTypes(_ types: [PkmRawType]) -> String {
        let string = types.map { localized($0.rawValue) }.joined(separator: ", ")
        return string.isEmpty ? "-" : string
    }

    var tableData: [EffectivenessRow] {
        let multipliers = typeCalculatorMultipliers
        var rows: [EffectivenessRow] = []

        for i in 0..<5 {
            let defStr = formatTypes(effectivenessDefenseSideData[i])
            let offStr = formatTypes(effectivenessOffenseSideData[i])

            // 过滤掉两端都为空（都是 "-"）的倍率行
            if defStr != "-" || offStr != "-" {
                rows.append(
                    EffectivenessRow(
                        multiplier: multipliers[i],
                        defense: defStr,
                        offense: offStr
                    ))
            }
        }
        return rows
    }

    var body: some View {
        VStack {
            Text(localized(TypeCalculatorConst.title))
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
                                    PkmRawType(
                                        rawValue: typeKeysLocalized[key] ?? "No Type")
                                    ?? .noType
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
                                    PkmRawType(
                                        rawValue: typeKeysLocalized[key] ?? "No Type")
                                    ?? .noType
                            }
                        ))
                }  // VStack

                // action
                VStack {
                    Button(localized(TypeCalculatorConst.textKeys[0])) {
                        clear()
                    }
                    .padding(.bottom, 5)

                    Button(localized(TypeCalculatorConst.textKeys[1])) {
                        Task(priority: .userInitiated) {
                            let effectiveness = TypeEffectiveness(
                                type1: vm.selectedType1, type2: vm.selectedType2)
                            await MainActor.run {
                                vm.typeEffectiveness = effectiveness
                            }
                        }
                    }
                }
                // result
                if vm.typeEffectiveness != nil {
                    Table(tableData) {
                        TableColumn(
                            localized(TypeCalculatorConst.textKeys[2]),
                            value: \EffectivenessRow.multiplier)
                        TableColumn(
                            localized(TypeCalculatorConst.textKeys[3]),
                            value: \EffectivenessRow.defense)
                        TableColumn(
                            localized(TypeCalculatorConst.textKeys[4]),
                            value: \EffectivenessRow.offense)
                    }
                    .frame(width: 400, height: 150)
                    .padding(.leading, 10)
                }
            }  // HStack
        }  // VStack
    }  // body

    private func clear() {
        vm.selectedType1 = .noType
        vm.selectedType2 = .noType
        vm.typeEffectiveness = nil
    }
}
