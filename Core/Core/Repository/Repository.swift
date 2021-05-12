//
//  Repository.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 24/10/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import Foundation

public protocol RepositoryType {
    
    var network: Network { get }
}

public class Repository: RepositoryType {

    public let network: Network
    
    public init(network: Network) {
        self.network = network
    }
}
