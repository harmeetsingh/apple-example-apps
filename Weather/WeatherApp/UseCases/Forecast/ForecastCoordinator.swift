//
//  ForecastCoordinator.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 24/10/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import UIKit

protocol ForecastCoordinatorType: Coordinator {

    func start(on window: UIWindow)
}

class ForecastCoordinator: ForecastCoordinatorType {
    
    private let repository: WeatherRepository
    private let forecastDetailsCoordinator: ForecastDetailsCoordinatorType
    private var presentingViewController: UIViewController?
    
    init(repository: WeatherRepository, forecastDetailsCoordinator: ForecastDetailsCoordinatorType) {
        self.repository = repository
        self.forecastDetailsCoordinator = forecastDetailsCoordinator
    }

    func start(on window: UIWindow) {
        
        let viewController: ForecastViewController = .fromStoryboard()
        viewController.viewModel = ForecastViewControllerViewModel(repository: repository, delegate: self)
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        presentingViewController = viewController
    }    
}

extension ForecastCoordinator: ForecastViewControllerViewModelDelegate {

    func didSelect(forecast: Forecast, on viewModel: ForecastViewControllerViewModelType) {

        guard let presentingViewController = presentingViewController else { return }
        forecastDetailsCoordinator.start(on: presentingViewController, with: forecast)
    }
}
