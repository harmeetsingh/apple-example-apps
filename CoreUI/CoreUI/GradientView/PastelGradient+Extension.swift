//
//  PastelGradient+Extension.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 15/04/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation

extension PastelGradient {
    
    public static func randomGradient() -> PastelGradient {
        let randomNumber = Int(arc4random_uniform(10))
        return PastelGradient(rawValue: randomNumber) ?? .warmFlame
    }
}
