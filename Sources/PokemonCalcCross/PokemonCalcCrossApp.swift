import DefaultBackend
import Observation
import SwiftCrossUI

@main
struct PokemonCalcCrossApp: App {
    let viewsKeys = ["Type Calculator", "Type Predictor"]
    @State var selectedViewKey: String? = nil
    @State var navigationPath = NavigationPath()

    var body: some Scene {
        WindowGroup("PokemonCalcCross") {
            VStack {
                Picker(of: viewsKeys, selection: $selectedViewKey)
            }
            .pickerStyle(.segmented)
        }
    }

    var backButton: some View {
        Button("Back") {
            navigationPath.removeLast()
        }
        .padding(.top, 10)
    }
}
