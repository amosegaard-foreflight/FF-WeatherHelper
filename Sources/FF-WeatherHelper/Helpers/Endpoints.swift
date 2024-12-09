import Foundation

/// Contains endpoints for the ForeFlight Weather API
public struct EndPoints {
    /// Creates the base URL components for the API
    /// 
    /// - Returns: URLComponents configured with the base API URL
    private static func createComponents() -> URLComponents {
        var c = URLComponents()
        c.scheme = "https"
        c.host = "qa.foreflight.com"
        return c
    }

    /// Creates a URLRequest for fetching weather report for a specific identifier
    /// 
    /// - Parameter identifier: The location identifier (e.g., ICAO code)
    /// - Returns: A configured URLRequest
    /// - Throws: RequestError if the URL cannot be constructed
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
