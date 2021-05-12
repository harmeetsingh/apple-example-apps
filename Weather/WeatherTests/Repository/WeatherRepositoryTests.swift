//
//  WeatherRepositoryTests.swift
//  WeatherAppTests
//
//  Created by Harmeet Singh on 07/11/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherRepositoryTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: WeatherRepository = Repository(network: mockNetwork)
    static var mockNetwork = MockNetwork()
    let validCityId = 1234567
        
    // MARK: - fetchForecasts
    
    func testFetchForecasts_InvalidCityId_ReturnsError() {
        
        let expectation = self.expectation(description: "testFetchForecasts_InvalidCityId_ReturnsError")

        sut.fetchForecasts(for: 0) { result in

            switch result {
                
            case .failure(let error):
                let expectedError = error as? WeatherRepositoryError
                let actualError = WeatherRepositoryError.cityIdInvalidLength(0)
                XCTAssertEqual(expectedError?.localizedDescription, actualError.localizedDescription)
                expectation.fulfill()

            default:
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchForecasts_RequestFailed_ReturnsError() {
        
        let expectation = self.expectation(description: "testFetchForecasts_RequestFailed_ReturnsError")

        sut.fetchForecasts(for: validCityId) { result in

            switch result {
                
            case .failure(let error):
                let expectedError = error as? MockError
                let actualError = MockError.instance
                XCTAssertEqual(expectedError?.localizedDescription, actualError.localizedDescription)
                expectation.fulfill()

            default:
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testFetchForecasts_RequestSuccessful_ReturnsObject() {
        
        let expectation = self.expectation(description: "testFetchForecasts_RequestSuccessful_ReturnsObject")
        
        WeatherRepositoryTests.mockNetwork.returnsResponseError = false
        WeatherRepositoryTests.mockNetwork.responseObject = [Forecast.fake()]
        sut.fetchForecasts(for: validCityId) { result in

            switch result {

                case .success(let forecasts):
                    XCTAssertEqual(forecasts.count, 1)
                    expectation.fulfill()

                default:
                    XCTFail()
                }
            }
        
        wait(for: [expectation], timeout: 0.1)
      }
}
