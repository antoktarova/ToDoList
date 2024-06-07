import UIKit

final class ListModuleAssembly: ModuleAssemblyProtocol {
    private let deps: Dependencies

    init(deps: Dependencies) {
        self.deps = deps
    }

    func createModule(_ configuration: Void) -> UIViewController {
        let router = ListRouter(deps: ListRouter.Dependencies(
            navigationController: deps.navigationController,
            detailAssembly: makeDetailAssembly(navigationController: deps.navigationController)
        )
        )
        let presenter = ListPresenter(dependencies: ListPresenter.Deps(router: router, noteService: deps.noteService))
        let vc = ListViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }

    func makeDetailAssembly(navigationController: UINavigationController) -> DetailModuleAssembly {
        DetailModuleAssembly(
            deps: DetailModuleAssembly.Dependencies(
                noteService: Services.userDefaults,
                navigationController: navigationController
            )
        )
    }
}

extension ListModuleAssembly {
    struct Dependencies {
        let noteService: NotesServiceProtocol
        let navigationController: UINavigationController
    }
}
