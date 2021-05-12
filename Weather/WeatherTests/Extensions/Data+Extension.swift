//
//  XCTest+Extension.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation

extension Data {
    
    static func from(jsonFileName fileName: String, className: AnyClass) -> Data? {
        
        if let url = Bundle(for: className.self).url(forResource: fileName, withExtension: "json") {
            
            return try? Data(contentsOf: url)
        }
        
        return nil
    }
}
