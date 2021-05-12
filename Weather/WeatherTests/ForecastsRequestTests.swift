//
//  ForecastRequestTests.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import XCTest
@testable import Weather
import Core

class ForecastsRequestTests: XCTestCase {
    
    // MARK: - Properties
    
    let sut = ForecastsRequest(cityID: 1234567)
    
    // MARK: - Lifecycle

    func testForecastRequest_NotNil() {
        XCTAssertNotNil(sut)
    }

    // MARK: - endpoint
    
    func testForecastRequest_Endpoint_CorrectValue() {
        XCTAssertEqual(sut.endpoint, "/data/2.5/forecast/daily")
    }

    // MARK: - method
    
    func testForecastRequest_Method_CorrectValue() {
        XCTAssertEqual(sut.method, HTTPMethodType.get)
    }

    // MARK: - query
    
    func testForecastRequest_Query_CorrectValue() {
         
        let expectedQuery = ["id" : "1234567",
                             "units" : "metric",
                             "appId" : "a78f88499f4ad371151071ae9cf48f00"
        ]
        
        XCTAssertEqual(sut.query, expectedQuery)
    }
}
