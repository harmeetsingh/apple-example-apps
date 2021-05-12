import Foundation
import UIKit

protocol Coordinator: class { }

enum CoordinatorPresentationType {
    case modally(animated: Bool)
    case show(animated: Bool)
}

extension Coordinator {
    func present(_ viewController: UIViewController,
                 _ type: CoordinatorPresentationType,
                 on parentViewController: UIViewController) {

        switch type {
        case .modally(animated: let isAnimated):

            let navigationController = UINavigationController(rootViewController: viewController)
            parentViewController.present(navigationController,
                                         animated: isAnimated)

        case .show(animated: let isAnimated):

            if let navigationController = parentViewController as? UINavigationController {
                navigationController.pushViewController(viewController,
                                                        animated: isAnimated)
            } else {
                parentViewController.show(viewController,
                                          sender: self)
            }
        }
    }
}
