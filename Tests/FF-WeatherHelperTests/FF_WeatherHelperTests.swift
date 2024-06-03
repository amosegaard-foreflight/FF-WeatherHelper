import XCTest
@testable import FF_WeatherHelper

final class FF_WeatherHelperTests: XCTestCase {

    func testRequestWorks() async throws {
        let airportIdentifier = "kpwm"
        
        // Attempt to create the request
        let request = try EndPoints.weatherReport(identifier: airportIdentifier)
        
        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Ensure the response data is not nil
        XCTAssertNotNil(data, "Response data should not be nil")
        
        // Ensure the response is a valid HTTP response and has a successful status code
        if let httpResponse = response as? HTTPURLResponse {
            XCTAssertEqual(httpResponse.statusCode, 200, "HTTP response status code should be 200")
        } else {
            XCTFail("Response was not a valid HTTPURLResponse")
        }
        
        // Attempt to decode the data into the WeatherReportModel
        do {
            let decodedWeatherModel = try JSONDecoder().decode(WeatherReportModel.self, from: data)
            XCTAssertNotNil(decodedWeatherModel, "Decoded weather model should not be nil")
            
            // Additional optional checks on the decoded model
            XCTAssertNotNil(decodedWeatherModel.report.conditions.text, "Conditions text should not be nil")
            XCTAssertNotNil(decodedWeatherModel.report.forecast.text, "Forecast text should not be nil")
        } catch {
            XCTFail("Decoding failed with error: \(error.localizedDescription)")
        }
    }

    
}
