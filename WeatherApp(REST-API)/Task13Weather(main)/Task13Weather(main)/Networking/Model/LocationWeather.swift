//
//  LocationWeather.swift
//  Task13Weather(main)
//
//  Created by Tymofii (Work) on 03.11.2021.
//

import Foundation

struct WeatherForDays: Codable {
    var sunriseTime: String?
    var sunsetTime: String?
    var weathers: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case sunriseTime = "sun_rice"
        case sunsetTime = "sun_set"
        case weathers = "consolidated_weather"
    }
}

struct Weather: Codable {
    var id: Int
    var applicableDate: String
    var stateName: String
    var stateAbbreviate: String
    var windSpeed: Float
    var windDirection: Float
    var windDirectionCompass: String
    var temp: Double
    var minTemp: Double
    var maxTemp: Double
    var airPressure: Float
    var humidity: Float
    var visibility: Float?
    var predictability: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case applicableDate = "applicable_date"
        case stateName = "weather_state_name"
        case stateAbbreviate = "weather_state_abbr"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case windDirectionCompass = "wind_direction_compass"
        case temp = "the_temp"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case airPressure = "air_pressure"
        case humidity = "humidity"
        case visibility = "visibility"
        case predictability = "predictability"
    }
}
