import Foundation
import UIKit

protocol DetailViewProtocol: AnyObject {
    func setNote(note: String)
    func showNewNotes()
}

protocol  DetailViewPresenterProtocol: AnyObject {
    init(router: Router, noteService: NotesServiceProtocol)
    func showNote()
    func saveNote(note: NoteModel)
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: Router?
    var noteService: NotesServiceProtocol
    
    required init(router: Router, noteService: NotesServiceProtocol) {
        self.router = router
        self.noteService = noteService
    }
    
    func showNote() {
        view?.setNote(note: "редактировать тут")
    }
    
    func saveNote(note: NoteModel) {
        noteService.appendOrUpdate(note: note)
        router?.popToRoot()
    }
}
