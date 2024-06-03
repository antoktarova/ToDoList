import UIKit

protocol ModuleAssemblyProtocol {
    associatedtype Configuration
    func createModule(_ configuration: Configuration) -> UIViewController
}

extension ModuleAssemblyProtocol where Configuration == Void {
    func createModule() -> UIViewController { createModule(()) }
}
