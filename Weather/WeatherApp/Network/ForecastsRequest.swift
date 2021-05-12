//
//  ForecastRequest.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Core

struct ForecastsRequest: NetworkRequest { 
    
    // MARK: - Properties
    
    private let cityID: Int
    
    // MARK: - Instantiation
    
    init(cityID: Int) {
        self.cityID = cityID
    }
    
    // MARK: - NetworkRequest
    
    var endpoint: String = "/data/2.5/forecast/daily"
    
    var method: HTTPMethodType = .get
    
    var query: [String: String]? {
        [
            "id" : String(describing: cityID), 
            "units" : "metric",
            "appId": "a78f88499f4ad371151071ae9cf48f00"
        ]
    }
    
    var headers: [String: String]? = nil
    
    var parameters: [String: AnyObject]? = nil
}
