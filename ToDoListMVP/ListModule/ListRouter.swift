import Foundation
import UIKit

protocol ListRouterProtocol {
    func open(note: NoteModel?)
}

final class ListRouter: ListRouterProtocol {
    private weak var navigationController: UINavigationController?
    private var detailAssembly: DetailModuleAssembly

    init(deps: Dependencies) {
        self.navigationController = deps.navigationController
        self.detailAssembly = deps.detailAssembly
    }

    func open(note: NoteModel?) {
        guard let navigationController else { return }
        let detailVC = detailAssembly.createModule(
            DetailModuleAssembly.Config(note: note)
        )
        navigationController.pushViewController(detailVC, animated: true)
    }
}

extension ListRouter {
    struct Dependencies {
        let navigationController: UINavigationController
        let detailAssembly: DetailModuleAssembly
    }
}
