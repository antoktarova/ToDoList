import Foundation
import UIKit

protocol DetailRouterProtocol {
    func back()
}

final class DetailRouter: DetailRouterProtocol {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func back() {
        navigationController?.popToRootViewController(animated: true)
    }
}
