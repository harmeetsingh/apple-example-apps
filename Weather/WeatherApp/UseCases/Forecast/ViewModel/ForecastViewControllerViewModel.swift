//
//  ForecastViewControllerViewModel.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 14/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import Foundation
import Bond

protocol ForecastViewControllerViewModelDelegate: class {

    func didSelect(forecast: Forecast, on viewModel: ForecastViewControllerViewModelType)
}

protocol ForecastViewControllerViewModelOutput {

    var city: Observable<String> { get }
    var temperature: Observable<String> { get }
    var hideErrorView: Observable<Bool> { get }
    var isLoading: Observable<Bool> { get }
    var cellViewModels: Observable<[ForecastTableViewCellViewModelType]> { get }
}

protocol ForecastViewControllerViewModelInput {

    func load()
    func select(indexPath: IndexPath?)
}

protocol ForecastViewControllerViewModelType {

    var outputs: ForecastViewControllerViewModelOutput { get }
    var inputs: ForecastViewControllerViewModelInput { get }
}

class ForecastViewControllerViewModel: ForecastViewControllerViewModelType, ForecastViewControllerViewModelOutput, ForecastViewControllerViewModelInput {

    var outputs: ForecastViewControllerViewModelOutput { return self }
    var inputs: ForecastViewControllerViewModelInput { return self }

    // MARK: - Properties
    
    private let repository: WeatherRepository
    private weak var delegate: ForecastViewControllerViewModelDelegate? { 
        didSet { 
            print("delegate is set")
        }
    }
    private let greaterLondonCityId = 2648110
    private var forecasts = [Forecast]()

    private(set) var city: Observable<String> = .init("Greater London")
    private(set) var temperature: Observable<String> = .init("")
    private(set) var hideErrorView: Observable<Bool> = .init(true)
    private(set) var isLoading: Observable<Bool> = .init(false)
    private(set) var cellViewModels: Observable<[ForecastTableViewCellViewModelType]> = .init([ForecastTableViewCellViewModelType]())

    // MARK: - Instantiation
    
    init(repository: WeatherRepository, delegate: ForecastViewControllerViewModelDelegate) {
        self.repository = repository
        self.delegate = delegate
    }
    
    func load() {
        isLoading.send(true)
        repository.fetchForecasts(for: greaterLondonCityId) { [weak self] result in

            guard let self = self else { return }
            self.isLoading.send(false)

            switch result {
                
            case .failure:
                self.hideErrorView.send(false)
                
            case .success(let forecasts):
                self.hideErrorView.send(true)
                self.forecasts = forecasts
                self.updateOutputs(with: forecasts)
            }
        }
    }

    func select(indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }

        let forecast = forecasts[indexPath.row]
        delegate?.didSelect(forecast: forecast, on: self)
    }

    private func updateOutputs(with forecasts: [Forecast]) {

        if let dayTemperature = forecasts.first?.dayTemperature {
            temperature.send("\(dayTemperature)°C")
        }

        let viewModels = forecasts
            .map { ForecastTableViewCellViewModel(with: $0) }
        
        cellViewModels.send(viewModels)
    }
}
