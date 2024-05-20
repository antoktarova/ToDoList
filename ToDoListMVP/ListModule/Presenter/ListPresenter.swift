import Foundation
import UIKit

protocol ListViewProtocol: AnyObject {
    func setNotes(notes: [NoteModel])
}

protocol ListViewPresenterProtocol: AnyObject {
    init(router: Router, noteService: NotesServiceProtocol)
    func fetchNotes()
    func addNote()
    func tapOnTheNote(note: NoteModel)
    func deleteNote(note: NoteModel)
}

class ListPresenter: ListViewPresenterProtocol {
    weak var view: ListViewProtocol?
    var router: Router?
    var noteService: NotesServiceProtocol
    
    required init(router: Router, noteService: NotesServiceProtocol) {
        self.router = router
        self.noteService = noteService
    }
    
    func fetchNotes() {
        let notes = noteService.getNotes()
        view?.setNotes(notes: notes)
    }
    
    func addNote() {
        router?.showDetail(note: nil)
    }
    
    func tapOnTheNote(note: NoteModel) {
        router?.showDetail(note: note)
    }
    
    func deleteNote(note: NoteModel) {
        noteService.deleteTask(note: note)
        let notes = noteService.getNotes()
        view?.setNotes(notes: notes)
    }
    
}
