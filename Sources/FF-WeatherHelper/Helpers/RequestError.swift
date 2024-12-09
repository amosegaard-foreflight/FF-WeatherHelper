import Foundation

/// Represents possible errors that can occur during API requests
public enum RequestError: Error {
    /// An unknown error occurred
    case unknown
    /// The URL provided is invalid
    case invalidUrl
    /// No internet connection is available
    case internetNotReachable
    /// The response data could not be parsed
    case couldNotParseData
    /// The input provided is invalid
    case invalidInput
    /// A server error occurred (5xx status code)
    case serverError
    
    /// Human-readable description of the error
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
            return "Server error occurred"
        default:
            return "Unknown error"
        }
    }
}
