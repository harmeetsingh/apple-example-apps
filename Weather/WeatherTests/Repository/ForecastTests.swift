//
//  ForecastTests.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ForecastTests: XCTestCase {
    
    // MARK: - Properties
    
    var forecast: Forecast?
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()

        guard let data = Data.from(jsonFileName: "ForecastRequest_ValidForecastItem", className: ForecastTests.self) else {

            return XCTFail("ForecastRequest_ValidForecastItem file not found")
        }
        
        forecast = try? JSONDecoder().decode(Forecast.self, from: data)
    }
    
    override func tearDown() {
        
        forecast = nil
        super.tearDown()
    }
    
    func testForecast_NotNil() {
        
        XCTAssertNotNil(forecast)
    }
    
    // MARK: - date

    func testInit_ValidJSON_DateCorrectValue() {
        
        XCTAssertEqual(forecast?.date.timeIntervalSince1970, 2551431600.0)
    }
    
    // MARK: - sunriseDate

    func testInit_ValidJSON_sunriseDateCorrectValue() {
        
        XCTAssertEqual(forecast?.sunriseDate.timeIntervalSince1970, 2551417442.0)
    }
    
    // MARK: - sunsetDate

    func testInit_ValidJSON_sunsetDateCorrectValue() {
        
        XCTAssertEqual(forecast?.sunsetDate.timeIntervalSince1970, 2551451078.0)
    }    

    // MARK: - pressure

    func testInit_ValidJSON_pressureDateCorrectValue() {
        
        XCTAssertEqual(forecast?.pressure, 993)
    }
    
    // MARK: - humidity

    func testInit_ValidJSON_humidityDateCorrectValue() {
        
        XCTAssertEqual(forecast?.humidity, 59)
    }

    // MARK: - windSpeed

    func testInit_ValidJSON_windSpeedDateCorrectValue() {
        
        XCTAssertEqual(forecast?.windSpeed, 5.07)
    }

    // MARK: - title
    
    func testInit_ValidJSON_TitleCorrectValue() {
        
        XCTAssertEqual(forecast?.title, "Clouds")
    }
    
    // MARK: - dayTemperature

    func testInit_ValidJSON_DayTemperatureCorrectValue() {
        
        XCTAssertEqual(forecast?.dayTemperature, 10)
    }
    
    // MARK: - nightTemperature

    func testInit_ValidJSON_NightTemperatureCorrectValue() {
        
        XCTAssertEqual(forecast?.nightTemperature, 7)
    }
    
    // MARK: - type

    func testInit_ValidJSON_TypeValue() {
        
        XCTAssertEqual(forecast?.type, ForecastType.darkClouds)
    }
}
