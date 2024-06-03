import XCTest
@testable import ToDoListMVPLocal

final class ArrayNoteRepositoryTests: XCTestCase {
    
    var sut = ArrayNoteService()
    
    override func setUp() {
        sut = ArrayNoteService()
    }
    
    func testWhenAppendWithoutUpdate() throws {
        let testArray: [NoteModel] = [
            NoteModel(id: UUID(), title: "1"),
            NoteModel(id: UUID(), title: "2"),
            NoteModel(id: UUID(), title: "3"),
            NoteModel(id: UUID(), title: "4")
        ]
        
        for note in testArray {
            sut.appendOrUpdate(note: note)
        }
        
        let expectation = self.expectation(description: "notes")
        var notes: [NoteModel] = []
        sut.getNotes {
            notes = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(testArray, notes)
    }

    func testWhenAppendWithUpdate() throws {
        let firstNote = NoteModel(id: UUID(), title: "2")
        sut.appendOrUpdate(note: firstNote)
        
        let secondNote = NoteModel(id: firstNote.id, title: "3286321879")
        sut.appendOrUpdate(note: secondNote)
        
        let expectation = self.expectation(description: "notes")
        var notes: [NoteModel] = []
        sut.getNotes {
            notes = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual([secondNote], notes)
    }
    
    
    func testWhenDelete() throws {
        
        let firstNote = NoteModel(id: UUID(), title: "1")
        var testArray: [NoteModel] = [
            firstNote,
            NoteModel(id: UUID(), title: "2"),
            NoteModel(id: UUID(), title: "3"),
            NoteModel(id: UUID(), title: "4")
        ]
        
        for note in testArray {
            sut.appendOrUpdate(note: note)
        }
        
        let secondNote = firstNote
        sut.deleteTask(note: secondNote)
        
        testArray.remove(at: 0)
        
        let expectation = self.expectation(description: "notes")
        var notes: [NoteModel] = []
        sut.getNotes {
            notes = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(testArray, notes)
    }
}
