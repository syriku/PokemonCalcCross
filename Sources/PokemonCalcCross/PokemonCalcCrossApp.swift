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
            NavigationStack(path: $navigationPath) {
                HStack {
                    NavigationLink(viewsKeys[0], value: viewsKeys[0], path: $navigationPath)
                    NavigationLink(viewsKeys[1], value: viewsKeys[1], path: $navigationPath)
                }
            }
            .navigationDestination(for: String.self) { key in
                VStack {
                    switch key {
                    case viewsKeys[0]:
                        Text("Type Calculator View")
                    case viewsKeys[1]:
                        Text("Type Predictor View")
                    default:
                        Text("Unknown View")
                    }
                    backButton
                }
            }
        }
    }

    var backButton: some View {
        Button("Back") {
            navigationPath.removeLast()
        }
        .padding(.top, 10)
    }
}
