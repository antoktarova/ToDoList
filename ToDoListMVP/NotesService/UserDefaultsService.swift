import UIKit

class UserDefaultsService: NotesServiceProtocol {
    
    static let shared = UserDefaultsService()
    private let userDefaults = UserDefaults.standard
    
    private init() {} 
    
    func getNotes() -> [NoteModel] {
        guard let data = userDefaults.data(forKey: "notes") else {
            return []
        }
        
        let decoder = PropertyListDecoder()
        let notes = try? decoder.decode([NoteModel].self, from: data)
        return notes ?? []
    }
    
    func appendOrUpdate(note: NoteModel) {
        var notes = getNotes()
        
        var targetIndex: Int? = nil
        for (index, element) in notes.enumerated() {
            if element.id == note.id {
                targetIndex = index
            }
        }
        
        if let targetIndex = targetIndex {
            notes[targetIndex] = note
        } else {
            notes.append(note)
        }
        
        saveNotes(notes: notes)
    }
    
    func deleteTask(note: NoteModel) {
        var notes = getNotes()
        
        for (index, element) in notes.enumerated() {
            if element.id == note.id {
                notes.remove(at: index)
            }
        }
        
        saveNotes(notes: notes)
    }
    
    private func saveNotes(notes: [NoteModel]) {
        let encoder = PropertyListEncoder()
        let data = try! encoder.encode(notes)
        userDefaults.set(data, forKey: "notes")
    }
}
