//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 04/11/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import Foundation

extension String { 
   
    var capitalizedSentance: String { 

        return self.components(separatedBy: " ")
            .map { $0.capitalizeFirstLetter }
            .reduce("") { (result, next) -> String in
                return "\(result) \(next)"
        }
    }
    
    var capitalizeFirstLetter: String {
        
        guard let nonCapitalized = self.first else {
            return self
        }

        guard let capitalized = self.first?.uppercased() else {
            return self
        }

        return replacingOccurrences(of: "\(nonCapitalized)", with: capitalized)
    }
}
