import UIKit

final class ListModuleAssembler: ModuleAssemblerProtocol {
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func createModule() -> UIViewController {
        let listP = ListPresenter(router: dependencies.router, noteService: dependencies.noteService)
        let listVC = ListViewController(presenter: listP)
        listP.view = listVC
        return listVC
    }
}

extension ListModuleAssembler {
    struct Dependencies {
        let router: Router
        let noteService: NotesServiceProtocol
    }
}
