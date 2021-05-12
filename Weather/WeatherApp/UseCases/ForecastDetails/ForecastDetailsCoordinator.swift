//
//  ForecastDetailsCoordinator.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 04/11/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import UIKit

protocol ForecastDetailsCoordinatorType: Coordinator {

    func start(on presentingViewController: UIViewController, with forecast: Forecast)
}

class ForecastDetailsCoordinator: ForecastDetailsCoordinatorType {

    func start(on presentingViewController: UIViewController, with forecast: Forecast) {

        let viewController: ForecastDetailsViewController = .fromStoryboard()
        viewController.viewModel = ForecastDetailsViewModel(forecast: forecast)
        present(viewController, .show(animated: true), on: presentingViewController)
    }
}
