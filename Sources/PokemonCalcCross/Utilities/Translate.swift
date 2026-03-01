import Foundation

func localized(_ key: String) -> String {
    return NSLocalizedString(key, bundle: .module, comment: "")
}
