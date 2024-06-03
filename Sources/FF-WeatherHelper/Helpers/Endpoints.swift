import Foundation

struct EndPoints {
    private static var components: URLComponents = {
        var c = URLComponents()
        c.scheme = "https"
        c.host = "qa.foreflight.com"
        return c
    }()

    static func weatherReport(identifier: String) throws -> URLRequest {
        components.path = "/weather/report/"
        
        guard let url = components.url?.appending(path: identifier.lowercased() ) else {
            throw RequestError.invalidUrl
        }
        
        var request = URLRequest(url: url )
        request.httpMethod = "GET"
        request.setValue("1", forHTTPHeaderField: "ff-coding-exercise")

        return request
    }
}
