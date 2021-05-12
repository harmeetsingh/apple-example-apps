//
//  Forecast.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 07/11/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import Foundation
@testable import WeatherApp

extension Forecast {
    
    static func fake() -> Forecast {

        let data = Data.from(jsonFileName: "ForecastRequest_ValidForecastItem", className: ForecastTests.self)!
        return try! JSONDecoder().decode(Forecast.self, from: data)
    }
}
