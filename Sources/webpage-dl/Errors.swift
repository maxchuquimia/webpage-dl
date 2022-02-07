import Foundation

enum WebpageDLError: LocalizedError {
    case invalidURL
    case nonextistantFileURL
    case invalidWidth
    case invalidHeight
    case invalidExpression
    case timeout

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The provided URL argument is not a valid URL."
        case .nonextistantFileURL: return "The provided URL argument does not locate a valid file."
        case .invalidWidth: return "The width must be greater than 0."
        case .invalidHeight: return "The height must be greater than 0."
        case .invalidExpression: return "The expression was invalid."
        case .timeout: return "The operation timed out."
        }
    }

}
