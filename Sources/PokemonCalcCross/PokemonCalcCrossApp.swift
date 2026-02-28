import DefaultBackend
import Observation
import SwiftCrossUI

@main
struct PokemonCalcCrossApp: App {
    let viewsKeys = ["Type Calculator", "Type Predictor"]
    @State var selectedViewKey: String?

    init() {
        selectedViewKey = viewsKeys.first
    }

    var body: some Scene {
        WindowGroup("PokemonCalcCross") {
            VStack(spacing: 30) {
                Picker(of: viewsKeys, selection: $selectedViewKey)
                    .frame(alignment: .top)
                    .pickerStyle(.segmented)

                if let selectedViewKey = selectedViewKey {
                    switch selectedViewKey {
                    case "Type Calculator":
                        TypeCalculatorView()
                    case "Type Predictor":
                        TypePredictorView()
                    default:
                        Text("Unknown view")
                    }
                } else {
                    Text("Please select a view")
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .top)
        }
    }
}
