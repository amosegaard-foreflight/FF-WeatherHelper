import Foundation

/// Main class for fetching weather reports from the ForeFlight API
public class WeatherReportEndpoint {
    
    /// Fetches weather report for a specific location identifier
    /// 
    /// - Parameter identifier: The location identifier (e.g., ICAO code)
    /// - Returns: A WeatherReportModel containing the weather information
    /// - Throws: RequestError for various failure conditions:
    ///   - invalidInput: If identifier is empty or invalid
    ///   - internetNotReachable: If there's no internet connection
    ///   - serverError: If the server returns a 5xx error
    ///   - couldNotParseData: If the response cannot be parsed
    ///   - unknown: For other unexpected errors
    public static func fetchWeatherFor(identifier: String) async throws -> WeatherReportModel {
        guard !identifier.isEmpty else { throw RequestError.invalidInput }
        let request = try EndPoints.weatherReport(identifier: identifier)
        
        var data = Data()
        var response = URLResponse()
        
        do {
            let (d, r) = try await URLSession.shared.data(for: request)
            data = d
            response = r
        } catch {
            if NSURLErrorNotConnectedToInternet == (error as NSError).code {
                throw RequestError.internetNotReachable
            }
            print(error.localizedDescription)
            throw RequestError.unknown
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
                case 200...299: break
                case 400...499: throw RequestError.invalidInput
                case 500...599: throw RequestError.serverError
                default: throw RequestError.unknown
            }
        }
        
        do {
            let decodedWeatherModel = try JSONDecoder().decode(WeatherReportModel.self, from: data)
            
            let cachedData = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedData, for: request)
            
            return decodedWeatherModel
        } catch let error {
            print(error.localizedDescription)
            throw RequestError.couldNotParseData
        }
    }
    
    /// Attempts to fetch a cached weather report for a location
    /// 
    /// - Parameter identifier: The location identifier (e.g., ICAO code)
    /// - Returns: A WeatherReportModel if found in cache, nil otherwise
    public static func fetchCachedWeatherFor(identifier: String) async -> WeatherReportModel? {
        do {
            let request = try EndPoints.weatherReport(identifier: identifier)
            
            if let data = URLCache.shared.cachedResponse(for: request)?.data,
               let decodedWeatherModel = try? JSONDecoder().decode(WeatherReportModel.self, from: data) {
                return decodedWeatherModel
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
