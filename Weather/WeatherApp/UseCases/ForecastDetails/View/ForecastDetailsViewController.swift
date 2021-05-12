//
//  ForecastDetailsViewController.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 04/11/2019.
//  Copyright © 2019 harmeetsingh. All rights reserved.
//

import UIKit

class ForecastDetailsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dayTemeratureLabel: UILabel!
    @IBOutlet var nightTemperatureLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    // MARK: - Properties

    var viewModel: ForecastDetailsViewModelType!
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel.outputs)
    }
    
    private func bind(_ outputs: ForecastDetailsViewModelOutputs) {

        outputs.title
            .bind(to: titleLabel.reactive.text)
        
        outputs.dayTemperature
            .bind(to: dayTemeratureLabel.reactive.text)
        
        outputs.nightTemperature
            .bind(to: nightTemperatureLabel.reactive.text)
        
        outputs.sunset
            .bind(to: sunsetLabel.reactive.text)
        
        outputs.sunrise
            .bind(to: sunriseLabel.reactive.text)
        
        outputs.pressure
            .bind(to: pressureLabel.reactive.text)
        
        outputs.humidity
            .bind(to: humidityLabel.reactive.text)
        
        outputs.windSpeed
            .bind(to: windSpeedLabel.reactive.text)

        outputs.image
            .bind(to: imageView.reactive.image)
    }
} 
