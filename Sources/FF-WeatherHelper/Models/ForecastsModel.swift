import Foundation

public struct ForecastModel: Codable, Identifiable {
    public let id = UUID()
    
    public let text: String
    public let ident: String
    public let dateIssued: String
    public let conditions: [ConditionsModel]?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case ident = "ident"
        case dateIssued = "dateIssued"
        case conditions = "conditions"
    }
}
