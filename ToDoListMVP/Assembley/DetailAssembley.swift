import UIKit

final class DetailModuleAssembler: ModuleAssemblerProtocol {

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func createModule() -> UIViewController {
        let detailP = DetailPresenter(router: dependencies.router, noteService: dependencies.noteService)
        let detailVC = DetailViewController(presenter: detailP, note: dependencies.note)
        detailP.view = detailVC
        return detailVC
    }
}

extension DetailModuleAssembler {
    struct Dependencies {
        let router: Router
        let note: NoteModel?
        let noteService: NotesServiceProtocol
    }
}
