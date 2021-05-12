//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/03/2017.
//  Copyright © 2017 HarmeetSingh. All rights reserved.
//

import Foundation
import Core

protocol WeatherRepository {

    func fetchForecasts(for cityID: Int, completion: @escaping (Result<[Forecast], Error>) -> Void)
}

extension Repository: WeatherRepository {

    func fetchForecasts(for cityID: Int, completion: @escaping (Result<[Forecast], Error>) -> Void) {
        
        guard String(cityID).count == 7 else {
            let error = WeatherRepositoryError.cityIdInvalidLength(cityID)
            completion(.failure(error))
            return
        }

        let request = ForecastsRequest(cityID: cityID)
        let decoder = ForecastsResponseDecoder()

        network.load(request: request, decoder: decoder) { result in

            switch result {

            case .failure(let error):
                completion(.failure(error))

            case .success(let decodedData):

                guard let forecasts = decodedData as? [Forecast] else {
                    completion(.failure(RepositoryError.unexpectedResponseType))
                    return
                }

                completion(.success(forecasts))
            }
        }
    }
}
