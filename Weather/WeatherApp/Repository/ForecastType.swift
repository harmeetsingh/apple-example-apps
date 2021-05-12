//
//  DailyForecastImageType.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 11/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation
import UIKit

enum ForecastType: String {
    
    case sunny
    case sunnyCloudy
    case cloudy
    case darkClouds
    case rainShower
    case rain
    case thunderstorm
    case snow
    case mist
    case unknown
    
    init(with imageName: String?) {

        switch imageName {
            
        case "01d", "01n":
            
            self = .sunny
            
        case "02d", "02n":
            
            self = .sunnyCloudy
            
        case "03d", "03n":
            
            self = .cloudy
            
        case "04d", "04n":
            
            self = .darkClouds
            
        case "09d", "09n":
            
            self = .rainShower
            
        case "10d", "10n":
            
            self = .rain
            
        case "11d", "11n":
            
            self = .thunderstorm
            
        case "13d", "13n":
            
            self = .snow
            
        case "50d", "50n":
            
            self = .mist
            
        default:
            
            self = .unknown
        }
    }

    
    var image: UIImage? {
        
        return UIImage(named: rawValue)
    }
}
