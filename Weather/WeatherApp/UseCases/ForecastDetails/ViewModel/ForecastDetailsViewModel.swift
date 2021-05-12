//
//  ForecastDetailsViewModel.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 04/11/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import UIKit
import Bond

protocol ForecastDetailsViewModelOutputs {

    var title: Observable<String> { get } 
    var dayTemperature: Observable<String> { get } 
    var nightTemperature: Observable<String> { get }
    var sunrise: Observable<String> { get }
    var sunset: Observable<String> { get }
    var pressure: Observable<String> { get }
    var humidity: Observable<String> { get }
    var windSpeed: Observable<String> { get }
    var image: Observable<UIImage?> { get }
}

protocol ForecastDetailsViewModelType {

    var outputs: ForecastDetailsViewModelOutputs { get }
}

class ForecastDetailsViewModel: ForecastDetailsViewModelType, ForecastDetailsViewModelOutputs {
    
    // MARK: - Properties
    
    var outputs: ForecastDetailsViewModelOutputs { return self }
    
    let title: Observable<String> 
    let dayTemperature: Observable<String> 
    let nightTemperature: Observable<String>
    let sunrise: Observable<String>
    let sunset: Observable<String>
    let pressure: Observable<String>
    let humidity: Observable<String>
    let windSpeed: Observable<String>
    let image: Observable<UIImage?>
    
    // MARK: - Instantiation
    
    init(forecast: Forecast) {
        
        title = .init(forecast.description.capitalizedSentance)
        dayTemperature = .init("Day Temperature: \(forecast.dayTemperature)°C")
        nightTemperature = .init("Night Temperature: \(forecast.nightTemperature)°C")
        sunrise = .init("Sunrise: \(forecast.sunriseDate.time() ?? "")")
        sunset = .init("Sunset: \(forecast.sunsetDate.time() ?? "")")
        pressure = .init("Pressure: \(forecast.pressure) hPa")
        humidity = .init("Humidity: \(forecast.humidity) %")
        windSpeed = .init("Wind: \(forecast.windSpeed) m/s")
        image = .init(forecast.type.image)
    }
}
