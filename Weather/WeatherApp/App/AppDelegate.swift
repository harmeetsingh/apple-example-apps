//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 10/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit
import Core

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties

    var window: UIWindow?
    var forecastCoordinator: ForecastCoordinatorType?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            return false
        }

        let networkSession = NetworkSession(
            session: URLSession.shared, 
            domain: "https://api.openweathermap.org"
        )

        let repository = Repository(network: networkSession)
        let coordinatorFactory = CoordinatorFactory(repository: repository)
        forecastCoordinator = coordinatorFactory.makeForecast()
        forecastCoordinator?.start(on: window)
        return true
    }
}
