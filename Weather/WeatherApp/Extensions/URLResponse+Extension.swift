//
//  URLResponse+Extension.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 15/04/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation

extension URLResponse {
    
    var isSuccessfull: Bool {

        let httpResponse = self as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        let range = Range(uncheckedBounds: (lower: 200, upper: 300))
        return range.contains(statusCode)
    }
}
