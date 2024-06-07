import SnapshotTesting
import XCTest
@testable import ToDoListMVPLocal

class MyViewControllerTests: XCTestCase {
    
    final class MockService: NotesServiceProtocol {
        var testNotes = [NoteModel(id: UUID(), title: "1234")]
        
        func getNotes(completion: @escaping ([NoteModel]) -> ()) {
            completion(testNotes)
        }
        
        func appendOrUpdate(note: NoteModel) {
            testNotes.append(note)
        }
        
        func deleteTask(note: NoteModel) {
            guard let index = testNotes.firstIndex(of: note) else { return }
            testNotes.remove(at: index)
        }
    }
    
    final class MockPresenter: ListViewPresenterProtocol {
        let noteService = MockService()
        let view: ListViewProtocol? = nil
        func fetchNotes() {
            noteService.getNotes { [weak self] notes in
                DispatchQueue.main.async {
                    self?.view?.setNotes(notes: notes)
                }
            }
        }
        
        func addNote() {
            return
        }
        
        func tapOnTheNote(note: ToDoListMVPLocal.NoteModel) {
            return
        }
        
        func deleteNote(note: ToDoListMVPLocal.NoteModel) {
            return
        }
    }
    
    func testMyViewController() {
        let presenter = MockPresenter()
        let vc = ListViewController(presenter: presenter)
        assertSnapshot(of: vc, as: .image, record: false)
    }
}
