import Foundation
import UIKit

protocol DetailViewPresenterProtocol: AnyObject {
    func saveNote(note: NoteModel)
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    private var router: DetailRouterProtocol
    private var noteService: NotesServiceProtocol

    required init(dependencies: Deps) {
        self.router = dependencies.router
        self.noteService = dependencies.noteService
    }

    func saveNote(note: NoteModel) {
        noteService.appendOrUpdate(note: note)
        router.back()
    }
}

extension DetailPresenter {
    struct Deps {
        var router: DetailRouterProtocol
        var noteService: NotesServiceProtocol
    }
}
