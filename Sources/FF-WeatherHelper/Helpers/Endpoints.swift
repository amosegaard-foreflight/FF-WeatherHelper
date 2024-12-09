import Foundation

/// A structure that manages API endpoint configurations for the ForeFlight weather service
public struct EndPoints {
    /// The base API URL host
    private static let host = "qa.foreflight.com"
    
    /// Creates and configures the base URL components for the API
    /// - Returns: Configured URLComponents with scheme and host
    private static func createComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        return components
    }

    /// Creates a URLRequest for fetching a weather report for a specific identifier
    /// - Parameter identifier: The airport or location identifier for the weather report
    /// - Returns: A configured URLRequest for the weather report endpoint
    /// - Throws: RequestError.invalidUrl if the URL cannot be constructed
    public static func weatherReport(identifier: String) throws -> URLRequest {
        var components = createComponents()
        components.path = "/weather/report/"
        
        guard let url = components.url?.appendingPathComponent(identifier.lowercased()) else {
            throw RequestError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("1", forHTTPHeaderField: "ff-coding-exercise")
        
        return request
    }
}
