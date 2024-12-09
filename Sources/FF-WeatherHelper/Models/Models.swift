import Foundation

/// Represents a layer of clouds in the atmosphere
public struct CloudLayer: Codable {
    /// The coverage description of the cloud layer (e.g., "BKN", "OVC", "SCT")
    public let coverage: String
    /// The altitude of the cloud layer in feet
    public let altitudeFt: Double
    /// Indicates if this layer represents a ceiling
    public let ceiling: Bool
}

/// Contains information about visibility conditions
public struct Visibility: Codable {
    /// The visibility distance in statute miles
    public let distanceSm: Double
    /// The prevailing visibility in statute miles, if different from distanceSm
    public let prevailingVisSm: Double?
    /// Qualifier for the distance visibility
    public let distanceQualifier: Int?
    /// Qualifier for the prevailing visibility
    public let prevailingVisDistanceQualifier: Int?
}

/// Contains wind condition information
public struct Wind: Codable {
    /// The wind speed in knots
    public let speedKts: Double
    /// The gust speed in knots, if any
    public let gustSpeedKts: Double?
    /// The wind direction in degrees
    public let direction: Int?
    /// The direction the wind is coming from in degrees
    public let from: Int?
    /// Indicates if the wind direction is variable
    public let variable: Bool
}

/// Represents a time period with start and end dates
public struct Period: Codable {
    /// The start date and time of the period in ISO 8601 format
    public let dateStart: String
    /// The end date and time of the period in ISO 8601 format
    public let dateEnd: String
}

/// Contains detailed weather conditions information
public struct ConditionsModel: Codable, Identifiable {
    /// Unique identifier for the conditions
    public let id = UUID()
    
    /// Raw text of the weather conditions report
    public let text: String
    /// Location identifier (e.g., ICAO code)
    public let ident: String?
    /// Temperature in Celsius
    public let tempC: Double?
    /// Dewpoint temperature in Celsius
    public let dewpointC: Double?
    /// Atmospheric pressure in inches of mercury
    public let pressureHg: Double?
    /// Atmospheric pressure in hectopascals
    public let pressureHpa: Double?
    /// Indicates if pressure was reported in hectopascals
    public let reportedAsHpa: Bool?
    /// Density altitude in feet
    public let densityAltitudeFt: Double?
    /// Relative humidity percentage (0-100)
    public let relativeHumidity: Int?
    /// Flight rules in effect (e.g., VFR, IFR, MVFR)
    public let flightRules: String?
    /// Array of cloud layers
    public let cloudLayers: [CloudLayer]
    /// Alternative representation of cloud layers
    public let cloudLayersV2: [CloudLayer]
    /// Array of weather phenomena descriptions
    public let weather: [String]
    /// Date and time when the conditions were issued
    public let dateIssued: String?
    /// Latitude of the reporting station
    public let lat: Double?
    /// Longitude of the reporting station
    public let lon: Double?
    /// Elevation of the reporting station in feet
    public let elevationFt: Double?
    /// Visibility information
    public let visibility: Visibility?
    /// Wind conditions
    public let wind: Wind?
    /// Time period for which these conditions are valid
    public let period: Period?
    
    enum CodingKeys: String, CodingKey {
        case text, ident, tempC, dewpointC, pressureHg, pressureHpa, reportedAsHpa, densityAltitudeFt, relativeHumidity, flightRules, cloudLayers, cloudLayersV2, weather, dateIssued, lat, lon, elevationFt, visibility, wind, period
    }
}

/// Contains forecast information for a location
public struct ForecastModel: Codable, Identifiable {
    /// Unique identifier for the forecast
    public let id = UUID()
    
    /// Raw text of the forecast
    public let text: String
    /// Location identifier (e.g., ICAO code)
    public let ident: String
    /// Date and time when the forecast was issued
    public let dateIssued: String
    /// Time period for which this forecast is valid
    public let period: Period
    /// Latitude of the forecast location
    public let lat: Double?
    /// Longitude of the forecast location
    public let lon: Double?
    /// Elevation of the forecast location in feet
    public let elevationFt: Double?
    /// Array of forecasted conditions
    public let conditions: [ConditionsModel]?
    
    enum CodingKeys: String, CodingKey {
        case text, ident, dateIssued, period, lat, lon, elevationFt, conditions
    }
}

/// Contains winds and temperature information for a specific altitude
public struct WindTemps: Codable {
    /// True direction from which the wind is blowing
    public let directionFromTrue: Int
    /// Wind speed in knots
    public let knots: Double
    /// Temperature in Celsius
    public let celsius: Double
    /// Altitude at which these conditions were observed
    public let altitude: Double
    /// Indicates if wind is light and variable
    public let isLightAndVariable: Bool
    /// Indicates if wind speed exceeds 199 knots
    public let isGreaterThan199Knots: Bool
    /// Indicates presence of turbulence
    public let turbulence: Bool
    /// Indicates presence of icing conditions
    public let icing: Bool
}

/// Contains winds aloft information for a specific time
public struct WindsAloft: Codable {
    /// Time when these conditions are valid
    public let validTime: String
    /// Time period for which these conditions are valid
    public let period: Period
    /// Dictionary of wind and temperature conditions keyed by altitude or level
    public let windTemps: [String: WindTemps]
}

/// Contains complete winds aloft forecast information
public struct WindsAloftModel: Codable {
    /// Latitude of the forecast location
    public let lat: Double
    /// Longitude of the forecast location
    public let lon: Double
    /// Date and time when the forecast was issued
    public let dateIssued: String
    /// Array of winds aloft forecasts
    public let windsAloft: [WindsAloft]
    /// Source of the forecast data
    public let source: String
}

/// Model Output Statistics forecast information
public struct MOSModel: Codable {
    /// Station identifier
    public let station: String
    /// Date and time when the forecast was issued
    public let issued: String
    /// Time period for which the forecast is valid
    public let period: Period
    /// Latitude of the forecast location
    public let latitude: Double
    /// Longitude of the forecast location
    public let longitude: Double
    /// Detailed forecast information
    public let forecast: ForecastModel
}

/// Contains complete weather report information
public struct ReportModel: Codable, Identifiable {
    /// Unique identifier for the report
    public let id = UUID()
    /// Current weather conditions
    public var conditions: ConditionsModel
    /// Weather forecast
    public var forecast: ForecastModel
    /// Winds aloft forecast, if available
    public var windsAloft: WindsAloftModel?
    /// Model Output Statistics forecast, if available
    public var mos: MOSModel?
    
    enum CodingKeys: String, CodingKey {
        case conditions, forecast, windsAloft, mos
    }
}

/// Top-level container for weather report information
public struct WeatherReportModel: Codable, Identifiable {
    /// Unique identifier for the weather report
    public let id = UUID()
    /// Complete weather report
    public var report: ReportModel
    
    enum CodingKeys: String, CodingKey {
        case report
    }
}
