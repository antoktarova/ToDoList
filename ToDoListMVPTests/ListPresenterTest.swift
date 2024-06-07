import XCTest
@testable import ToDoListMVPLocal

final class MockVC: ListViewProtocol {
    var testNotes: [NoteModel] = []
    var setCompletion: (() -> ())? = nil
    func setNotes(notes: [NoteModel]) {
        testNotes = notes
        setCompletion?()
    }
}

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

final class MockRouter: ListRouterProtocol {
    var note: NoteModel? = NoteModel(id: UUID(), title: "1234")
    func open(note: ToDoListMVPLocal.NoteModel?) {
        self.note = note
    }
}

final class ListPresenterTest: XCTestCase {

    private var presenter: ListPresenter!
    private var viewController: MockVC!
    private var mockService: MockService!
    private var mockRouter: MockRouter!

    override func setUp() {
        self.mockService = MockService()
        self.mockRouter = MockRouter()
        self.viewController = MockVC()

        self.presenter = ListPresenter(
            dependencies: ListPresenter.Deps(
                router: mockRouter,
                noteService: mockService
            )
        )
        self.presenter.view = viewController
    }

    func testFetch() throws {
        let expectation = self.expectation(description: "1")
        viewController.setCompletion = {
            expectation.fulfill()
        }

        presenter.fetchNotes()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewController.testNotes, mockService.testNotes)
    }
    
    func testDelete() throws {
        let expectation = self.expectation(description: "1")
        viewController.setCompletion = {
            expectation.fulfill()
        }

        presenter.deleteNote(note: mockService.testNotes[0])
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(viewController.testNotes, mockService.testNotes)
    }
    
    func testAdd() throws {
        presenter.addNote()
        
        XCTAssertEqual(mockRouter.note, nil)
    }
    
    func testTapOnTheNote() throws {
        var note = NoteModel(id: UUID(), title: "123")
        presenter.tapOnTheNote(note: note)
        
        XCTAssertEqual(mockRouter.note, note)
    }
}

