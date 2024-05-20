import UIKit

protocol NotesServiceProtocol {
    func getNotes() -> [NoteModel]
    func appendOrUpdate(note: NoteModel)
    func deleteTask(note: NoteModel)
}
