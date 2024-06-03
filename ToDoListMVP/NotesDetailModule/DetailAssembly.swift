import UIKit

final class DetailModuleAssembly: ModuleAssemblyProtocol {
    private let deps: Dependencies

    init(deps: Dependencies) {
        self.deps = deps
    }

    func createModule(_ configuration: Config) -> UIViewController {
        let router = DetailRouter(navigationController: deps.navigationController)
        let presenter = DetailPresenter(dependencies: DetailPresenter.Deps(router: router, noteService: deps.noteService))
        let vc = DetailViewController(presenter: presenter, note: configuration.note)
        presenter.view = vc
        return vc
    }
}

extension DetailModuleAssembly {
    struct Config {
        let note: NoteModel?
    }

    struct Dependencies {
        let noteService: NotesServiceProtocol
        let navigationController: UINavigationController
    }
}
