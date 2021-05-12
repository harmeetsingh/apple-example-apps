import UIKit

extension UITableView {
    public func dequeueCell<T: UITableViewCell>(of classType: T.Type, for indexPath: IndexPath) -> T {
        guard let dequeuedCell = self.dequeueReusableCell(withIdentifier: classType.reuseIdentifier,
                                                          for: indexPath) as? T else {
            fatalError("Could not dequeue reusable cell of type \(T.self)")
        }
        return dequeuedCell
    }

    public func deselectSelectedRow(animated: Bool = false) {
        if let indexPath = indexPathForSelectedRow {
            deselectRow(at: indexPath,
                        animated: animated)
        }
    }
}
