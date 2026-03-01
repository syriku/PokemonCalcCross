import DefaultBackend
import Foundation
import Observation
import SwiftCrossUI

@main
struct PokemonCalcCrossApp: App {

    let viewsKeys = ViewRoute.allCases.map { $0.rawValue }

    @State var selectedViewKey: String?

    init() {

        selectedViewKey = viewsKeys.first

    }

    var body: some Scene {
        WindowGroup(localized(appTitle)) {
            VStack(spacing: 30) {
                Picker(
                    of: viewsKeys.map { localized($0) },
                    selection: Binding(
                        get: {
                            localized(selectedViewKey!)
                        },
                        set: { it in
                            selectedViewKey = viewsKeys.first(where: {
                                localized($0) == it
                            })
                        })
                )
                .pickerStyle(.segmented)
                .padding(.top, 5)

                if let selectedViewKey = selectedViewKey,
                    let route = ViewRoute(rawValue: selectedViewKey)
                {
                    switch route {
                    case .typeCalculator:
                        TypeCalculatorView()
                    case .typePredictor:
                        TypePredictorView()
                    }
                } else {
                    Text("Please select a view")
                }
                Spacer()
            }
            .frame(alignment: .top)
        }
    }
}
