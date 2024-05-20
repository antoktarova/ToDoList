import UIKit

class ArrayNoteService: NotesServiceProtocol {
    
    static let shared = ArrayNoteService()
    private var notesList: [NoteModel] = []
    
    private init() {}
    
    func getNotes() -> [NoteModel] {
        return notesList
    }
    
    func appendOrUpdate(note: NoteModel) {
        var targetIndex: Int? = nil
        for (index, element) in notesList.enumerated() {
            if element.id == note.id {
                targetIndex = index
            }
        }
        
        if let targetIndex = targetIndex {
            notesList[targetIndex] = note
        } else {
            notesList.append(note)
        }
    }
    
    func deleteTask(note: NoteModel) {
        for (index, element) in notesList.enumerated() {
            if element.id == note.id {
                notesList.remove(at: index)
            }
        }
    }
}

