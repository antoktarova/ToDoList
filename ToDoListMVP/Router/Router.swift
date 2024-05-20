import Foundation
import UIKit

class Router {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            let dependencies = ListModuleAssembler.Dependencies(router: self, noteService: ArrayNoteService.shared)
            let listViewController = ListModuleAssembler(dependencies: dependencies).createModule()
            navigationController.viewControllers = [listViewController]
        }
    }
    
    func showDetail(note: NoteModel?) {
        if let navigationController = navigationController {
            let dependencies = DetailModuleAssembler.Dependencies(router: self, note: note, noteService: ArrayNoteService.shared)
            let detailViewController = DetailModuleAssembler(dependencies: dependencies).createModule()
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
