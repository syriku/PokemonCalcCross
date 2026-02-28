import DefaultBackend
import Observation
import SwiftCrossUI

@main
struct PokemonCalcCrossApp: App {
    enum ViewRoute: String, CaseIterable {
        case typeCalculator = "Type Calculator"
        case typePredictor = "Type Predictor"
    }

    let viewsKeys = ViewRoute.allCases.map { $0.rawValue }
    @State var selectedViewKey: String?

    init() {
        selectedViewKey = viewsKeys.first
    }

    var body: some Scene {
        WindowGroup("PokemonCalcCross") {
            VStack(spacing: 30) {
                Picker(of: viewsKeys, selection: $selectedViewKey)
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
        .defaultSize(width: 400, height: 300)
    }
}
