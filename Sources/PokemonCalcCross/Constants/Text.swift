let appTitle = "PokemonCalc"

enum ViewRoute: String, CaseIterable {
    case typeCalculator = "Type Calculator"
    case typePredictor = "Type Predictor"
}

let typeCalculatorTitle = ViewRoute.typeCalculator.rawValue
