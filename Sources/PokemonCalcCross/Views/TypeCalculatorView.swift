import Foundation
import SwiftCrossUI

struct TypeCalculatorView: View {
    let typeKeys = PkmType.allCases.map { $0.rawValue }
    let typeKeysLocalized: Dictionary<String, String>
    let localizedKeys: [String]
    @State var selectedType1Key: String?
    @State var selectedType2Key: String?

    init() {
        var temp: [String: String] = [:]
        for it in typeKeys {
            temp[it] = NSLocalizedString(it, bundle: .module, comment: "type name")
        }
        typeKeysLocalized = temp
        localizedKeys = typeKeys.map { temp[$0] ?? $0 }
        selectedType1Key = typeKeysLocalized[PkmType.noType.rawValue]
        selectedType2Key = typeKeysLocalized[PkmType.noType.rawValue]
    }
    
    var body: some View {
        VStack {
            Text("Type Calculator")
                .font(.title)
                .padding()
                .padding(.bottom, 20)
            
            // first type
            Picker(of: localizedKeys, selection: $selectedType1Key)
                .padding(.bottom, 5)
            // second type
            Picker(of: localizedKeys, selection: $selectedType2Key)
        }
    }
}
