//
//  ForecastTableViewCellViewModel.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 19/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit
import Bond

protocol ForecastTableViewCellViewModelOutputs {

    var temperature: Observable<String> { get }
    var day: Observable<String> { get }
    var image: Observable<UIImage?> { get }
}

protocol ForecastTableViewCellViewModelType { 
    
    var outputs: ForecastTableViewCellViewModelOutputs { get }
} 

class ForecastTableViewCellViewModel: ForecastTableViewCellViewModelType, ForecastTableViewCellViewModelOutputs {
    
    // MARK:-  Properties
    
    var outputs: ForecastTableViewCellViewModelOutputs { return self }

    private(set) var temperature: Observable<String> = .init("")
    private(set) var day: Observable<String> = .init("")
    private(set) var image: Observable<UIImage?> = .init(nil)
    
    // MARK: - Instantiation
    
    init(with forecast: Forecast) {
        
        if let dayOfWeek = forecast.date.dayOfWeek() {
            day.send(dayOfWeek)
        }
        
        temperature.send("\(forecast.dayTemperature)°C")
        image.send(forecast.type.image)
    }
}
