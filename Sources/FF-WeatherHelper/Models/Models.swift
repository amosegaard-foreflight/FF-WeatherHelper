import Foundation

public struct CloudLayer: Codable {
    public let coverage: String
    public let altitudeFt: Double
    public let ceiling: Bool
}

public struct Visibility: Codable {
    public let distanceSm: Double
    public let prevailingVisSm: Double?
    public let distanceQualifier: Int?
    public let prevailingVisDistanceQualifier: Int?
}

public struct Wind: Codable {
    public let speedKts: Double
    public let gustSpeedKts: Double?
    public let direction: Int?
    public let from: Int?
    public let variable: Bool
}

public struct Period: Codable {
    public let dateStart: String
    public let dateEnd: String
}

public struct ConditionsModel: Codable, Identifiable {
    public let id = UUID()
    
    public let text: String
    public let ident: String?
    public let tempC: Double?
    public let dewpointC: Double?
    public let pressureHg: Double?
    public let pressureHpa: Double?
    public let reportedAsHpa: Bool?
    public let densityAltitudeFt: Double?
    public let relativeHumidity: Int? // [0:100]
    public let flightRules: String?
    public let cloudLayers: [CloudLayer]
    public let cloudLayersV2: [CloudLayer]
    public let weather: [String]
    public let dateIssued: String?
    public let lat: Double?
    public let lon: Double?
    public let elevationFt: Double?
    public let visibility: Visibility?
    public let wind: Wind?
    public let period: Period?
    
    enum CodingKeys: String, CodingKey {
        case text, ident, tempC, dewpointC, pressureHg, pressureHpa, reportedAsHpa, densityAltitudeFt, relativeHumidity, flightRules, cloudLayers, cloudLayersV2, weather, dateIssued, lat, lon, elevationFt, visibility, wind, period
    }
}

public struct ForecastModel: Codable, Identifiable {
    public let id = UUID()
    
    public let text: String
    public let ident: String
    public let dateIssued: String
    public let period: Period
    public let lat: Double?
    public let lon: Double?
    public let elevationFt: Double?
    public let conditions: [ConditionsModel]?
    
    enum CodingKeys: String, CodingKey {
        case text, ident, dateIssued, period, lat, lon, elevationFt, conditions
    }
}

public struct WindTemps: Codable {
    public let directionFromTrue: Int
    public let knots: Double
    public let celsius: Double
    public let altitude: Double
    public let isLightAndVariable: Bool
    public let isGreaterThan199Knots: Bool
    public let turbulence: Bool
    public let icing: Bool
}

public struct WindsAloft: Codable {
    public let validTime: String
    public let period: Period
    public let windTemps: [String: WindTemps]
}

public struct WindsAloftModel: Codable {
    public let lat: Double
    public let lon: Double
    public let dateIssued: String
    public let windsAloft: [WindsAloft]
    public let source: String
}

public struct MOSModel: Codable {
    public let station: String
    public let issued: String
    public let period: Period
    public let latitude: Double
    public let longitude: Double
    public let forecast: ForecastModel
}

public struct ReportModel: Codable, Identifiable {
    public let id = UUID()
    public var conditions: ConditionsModel
    public var forecast: ForecastModel
    public var windsAloft: WindsAloftModel?
    public var mos: MOSModel?
    
    enum CodingKeys: String, CodingKey {
        case conditions, forecast, windsAloft, mos
    }
}

public struct WeatherReportModel: Codable, Identifiable {
    public let id = UUID()
    public var report: ReportModel
    
    enum CodingKeys: String, CodingKey {
        case report
    }
}
