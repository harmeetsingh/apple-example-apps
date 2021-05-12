//
//  Forecast.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    
    // MARK: - Properties
    
    let date: Date
    let sunriseDate: Date
    let sunsetDate: Date
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let title: String
    let description: String
    let dayTemperature: Int
    let nightTemperature: Int
    let type: ForecastType
    
    // MARK: - CodingKeys
    
    enum ForecastCodingKeys: String, CodingKey {
        
        case date = "dt"
        case weather, sunrise, sunset, pressure, humidity, speed
        case temperature = "temp"
    }
    
    enum WeatherCodingKeys: String, CodingKey {
        
        case title = "main"
        case description, icon
    }

    enum TemperatureCodingKeys: String, CodingKey {
        
        case dayTemperature = "day"
        case nightTemperature = "night"
    }
    
    // MARK: - Instantiation
    
    init(from decoder: Decoder) throws {
        
        let forecastContainer = try decoder.container(keyedBy: ForecastCodingKeys.self)
        date = try forecastContainer.decode(Date.self, forKey: .date)
        sunriseDate = try forecastContainer.decode(Date.self, forKey: .sunrise)
        sunsetDate = try forecastContainer.decode(Date.self, forKey: .sunset)
        pressure = try forecastContainer.decode(Int.self, forKey: .pressure)
        humidity = try forecastContainer.decode(Int.self, forKey: .humidity)
        windSpeed = try forecastContainer.decode(Double.self, forKey: .speed)
        
        var weatherArrayContainer = try forecastContainer.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try weatherArrayContainer.nestedContainer(keyedBy: WeatherCodingKeys.self)
        title = try weatherContainer.decode(String.self, forKey: .title)
        description = try weatherContainer.decode(String.self, forKey: .description)
        
        let iconName = try weatherContainer.decodeIfPresent(String.self, forKey: .icon)
        type = ForecastType(with: iconName)
        
        let tempreatureContainer = try forecastContainer.nestedContainer(keyedBy: TemperatureCodingKeys.self, forKey: .temperature)
        let dayTemperatureDoubleValue = try tempreatureContainer.decodeIfPresent(Double.self, forKey: .dayTemperature)
        let nightTemperatureDoubleValue = try tempreatureContainer.decodeIfPresent(Double.self, forKey: .nightTemperature)
        
        dayTemperature = Int(round(dayTemperatureDoubleValue ?? 0))
        nightTemperature = Int(round(nightTemperatureDoubleValue ?? 0))
    }
}
