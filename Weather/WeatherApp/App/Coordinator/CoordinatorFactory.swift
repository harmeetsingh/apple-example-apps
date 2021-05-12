import Foundation
import Core

protocol CoordinatorFactoryType {
    func makeForecast() -> ForecastCoordinatorType
}

struct CoordinatorFactory: CoordinatorFactoryType {

    let repository: Repository
    
    func makeForecast() -> ForecastCoordinatorType {
        return ForecastCoordinator(
            repository: repository, 
            forecastDetailsCoordinator: makeForecastDetails()
        )
    }
    
    func makeForecastDetails() -> ForecastDetailsCoordinatorType {
        return ForecastDetailsCoordinator()
    }
}
