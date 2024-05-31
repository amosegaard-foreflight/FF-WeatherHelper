import Foundation

enum RequestError: Error {
    case unknown, invalidUrl, internetNotReachable, couldNotParseData, invalidInput, serverError
    
    public var errorDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .internetNotReachable:
            return "Internet not reachable - try again later"
        case .couldNotParseData:
            return "Could not parse response"
        case .invalidInput:
            return "Invalid input"
        case .serverError:
            return "Invalid input"
        default:
            return "Unknown error"
        }
    }
}
