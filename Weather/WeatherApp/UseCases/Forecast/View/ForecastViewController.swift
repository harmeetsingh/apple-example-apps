//
//  ViewController.swift
//  WeatherApp
//
//  Created by Harmeet Singh on 10/01/2018.
//  Copyright © 2018 harmeetsingh. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit
import CoreUserInterface

class ForecastViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var degreesLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pastelView: PastelView!
    @IBOutlet var errorView: UIView!
    @IBOutlet var retryButton: UIButton!
    
    var viewModel: ForecastViewControllerViewModelType!
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePatelView()
        configureRefreshControl()
        bind(viewModel.inputs)
        bind(viewModel.outputs)
        refreshTriggered()
    }
    
    // MARK: - Configuration

    private func configurePatelView() {

        // Custom Direction
        pastelView?.startPastelPoint = .bottomLeft
        pastelView?.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView?.animationDuration = 3.0
        updatePastelGradient()
    }
    
    private func updatePastelGradient() {
        // Custom Color
        let gradient = PastelGradient.randomGradient()
        pastelView?.setPastelGradient(gradient)
        pastelView?.startAnimation()
    }
    
    private func configureRefreshControl() {
        
        tableView.addSubview(refreshControl)
        
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
    }
    
    @objc private func refreshTriggered() {
        viewModel.inputs.load()
        updatePastelGradient()
    }
    
    private func bind(_ inputs: ForecastViewControllerViewModelInput) {

        tableView.reactive.selectedRowIndexPath
            .observe { [weak self] signal in
                inputs.select(indexPath: signal.element)
                self?.tableView.deselectSelectedRow()
            }
            .dispose(in: disposeBag)
        
        retryButton.reactive.tap
            .observeNext(with: viewModel.inputs.load)
            .dispose(in: disposeBag)
    }
    
    private func bind(_ outputs: ForecastViewControllerViewModelOutput) {

        outputs.city
            .bind(to: cityLabel.reactive.text)
        
        outputs.temperature
            .bind(to: degreesLabel.reactive.text)

        outputs.isLoading
            .bind(to: refreshControl.reactive.refreshing)
        
        outputs.cellViewModels
            .bind(to: tableView) { dataSource, indexPath, tableView in            
                let cell = tableView.dequeueCell(of: ForecastTableViewCell.self, for: indexPath)
                cell.viewModel = dataSource[indexPath.row]
                return cell
        }
        
        outputs.hideErrorView
            .bind(to: errorView.reactive.isHidden)
    }
}
