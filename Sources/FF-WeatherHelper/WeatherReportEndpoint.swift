import Foundation

public class WeatherReportEndpoint {
    
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
    
    static func fetchCachedWeatherFor(identifier: String) async -> WeatherReportModel? {
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
