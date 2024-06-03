import UIKit

enum Services {
    static let userDefaults = UserDefaultsService()
    static let array = ArrayNoteService()
}

class ArrayNoteService: NotesServiceProtocol {
    private var notesList: [NoteModel] = []
    private let syncQueue = DispatchQueue(label: "arrayService")
    
    init() {}
    
    func getNotes(completion: @escaping ([NoteModel]) -> ()) {
        syncQueue.async { [weak self] in
            guard let self else { return }
            completion(notesList)
        }
    }
    
    func appendOrUpdate(note: NoteModel) {
        syncQueue.async { [weak self] in
            guard let self else { return }
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
    }
    
    func deleteTask(note: NoteModel) {
        syncQueue.async { [weak self] in
            guard let self else { return }
            for (index, element) in notesList.enumerated() {
                if element.id == note.id {
                    notesList.remove(at: index)
                }
            }
        }
    }
}
