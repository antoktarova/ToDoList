import UIKit

class UserDefaultsService: NotesServiceProtocol {
    private let userDefaults = UserDefaults.standard
    private let userDefaultQueue = DispatchQueue(label: "userDefaultService")
    
    init() {}
    
    func getNotes(completion: @escaping ([NoteModel]) -> ()) {
        userDefaultQueue.async { [weak self] in
            guard let data = self?.userDefaults.data(forKey: "notes") else { return completion([]) }
            
            let decoder = PropertyListDecoder()
            let notes = try? decoder.decode([NoteModel].self, from: data)
            completion(notes ?? [])
        }
    }
    
    func appendOrUpdate(note: NoteModel) {
        getNotes { [weak self] notes in
            var notes = notes
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
            
            self?.saveNotes(notes: notes)
        }
    }
    
    func deleteTask(note: NoteModel) {
        getNotes { [weak self] notes in
            var notes = notes
            for (index, element) in notes.enumerated() {
                if element.id == note.id {
                    notes.remove(at: index)
                }
            }
            self?.saveNotes(notes: notes)
        }
    }
    
    private func saveNotes(notes: [NoteModel]) {
        let encoder = PropertyListEncoder()
        let data = try! encoder.encode(notes)
        userDefaults.set(data, forKey: "notes")
    }
}

class MockUserDefaultService: NotesServiceProtocol {
    let userDefaults = UserDefaults.standard
    private let mockUserDefaultQueue = DispatchQueue(label: "mockUserDefaultService")
    
    init() {}
    
    func getNotes(completion: @escaping ([NoteModel]) -> ()) {
        mockUserDefaultQueue.async { [weak self] in
            guard let data = self?.userDefaults.data(forKey: "notesMock") else { return completion([]) }
            
            let decoder = PropertyListDecoder()
            let notes = try? decoder.decode([NoteModel].self, from: data)
            completion(notes ?? [])
        }
    }
    
    func appendOrUpdate(note: NoteModel) {
        getNotes { [weak self] notes in
            var notes = notes
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
            
            self?.saveNotes(notes: notes)
        }
    }
    
    func deleteTask(note: NoteModel) {
        getNotes { [weak self] notes in
            var notes = notes
            for (index, element) in notes.enumerated() {
                if element.id == note.id {
                    notes.remove(at: index)
                }
            }
            self?.saveNotes(notes: notes)
        }
    }
    
    private func saveNotes(notes: [NoteModel]) {
        let encoder = PropertyListEncoder()
        let data = try! encoder.encode(notes)
        userDefaults.set(data, forKey: "notesMock")
    }
}
