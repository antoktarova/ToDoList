import UIKit

protocol NotesServiceProtocol {
    func getNotes(completion: @escaping ([NoteModel]) -> ())
    func appendOrUpdate(note: NoteModel)
    func deleteTask(note: NoteModel)
}
