let appTitle = "PokemonCalc"

enum ViewRoute: String, CaseIterable {
    case typeCalculator = "Type Calculator"
    case typePredictor = "Type Predictor"
}

enum TypeCalculatorConst {
    static let textKeys = [
        "tc.clearButton",
        "tc.calcButton",
        "tc.multiplier",
        "tc.defenseSide",
        "tc.offenseSide",
    ]
    static let title = ViewRoute.typeCalculator.rawValue
}

let typeCalculatorMultipliers = ["x4", "x2", "x0.5", "x0.25", "x0"]
