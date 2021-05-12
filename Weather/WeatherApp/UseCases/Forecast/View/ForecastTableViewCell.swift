//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 10/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var viewModel: ForecastTableViewCellViewModelType!

    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bind(viewModel.outputs)
    }
    
    private func bind(_ outputs: ForecastTableViewCellViewModelOutputs) {

        outputs.day
            .bind(to: dayLabel.reactive.text)

        outputs.temperature
            .bind(to: degreesLabel.reactive.text)

        outputs.image
            .bind(to: weatherImageView.reactive.image)
    }    
}
