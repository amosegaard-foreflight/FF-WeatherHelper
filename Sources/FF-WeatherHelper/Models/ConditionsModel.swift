import Foundation

struct ConditionsModel: Codable, Identifiable {
    let id = UUID()
    
    public let text: String
    let ident: String?
    public let tempC: Double?
    let relativeHumidity: Int? // [0:100]
    public let weather: [String]
    let dateIssued: String
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case ident = "ident"
        case tempC = "tempC"
        case relativeHumidity = "relativeHumidity"
        case weather = "weather"
        case dateIssued = "dateIssued"
    }
}
