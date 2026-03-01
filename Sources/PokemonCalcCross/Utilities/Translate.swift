import Foundation

private var cache: [String: String] = [:]

func localized(_ key: String) -> String {
    if let cached = cache[key] {
        return cached
    }
    let localizedString = NSLocalizedString(key, bundle: .module, comment: "")
    cache[key] = localizedString
    return localizedString
}
