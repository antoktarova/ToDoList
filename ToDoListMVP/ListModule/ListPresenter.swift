import Foundation
import UIKit

protocol ListViewPresenterProtocol: AnyObject {
    func fetchNotes()
    func addNote()
    func tapOnTheNote(note: NoteModel)
    func deleteNote(note: NoteModel)
}

class ListPresenter: ListViewPresenterProtocol {
    weak var view: ListViewProtocol?
    private var router: ListRouterProtocol
    private var noteService: NotesServiceProtocol
    
    init(dependencies: Deps) {
        self.router = dependencies.router
        self.noteService = dependencies.noteService
    }
    
    func fetchNotes() {
        noteService.getNotes { [weak self] notes in
            DispatchQueue.main.async {
                self?.view?.setNotes(notes: notes)
            }
        }
    }
    
    func addNote() {
        router.open(note: nil)
    }
    
    func tapOnTheNote(note: NoteModel) {
        router.open(note: note)
    }
    
    func deleteNote(note: NoteModel) {
        noteService.deleteTask(note: note)
        noteService.getNotes { [weak self] notes in
            DispatchQueue.main.async {
                self?.view?.setNotes(notes: notes)
            }
        }
    }
}

extension ListPresenter {
    struct Deps {
        var router: ListRouterProtocol
        var noteService: NotesServiceProtocol
    }
}
