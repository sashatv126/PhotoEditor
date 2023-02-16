import UIKit
import PhotoEditorKit
import PhotoEditorUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var rootController: UINavigationController {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        return window?.rootViewController as! UINavigationController
    }
    
   private lazy var coordinator: Coordinatable = self.makeCoordinator()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        coordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
    
}

private extension AppDelegate {
    func makeCoordinator() -> Coordinatable {
        let coordinatorFactory = CoordinatorFactory()
        let router = Router(rootController: rootController)
        return AppCoordinator(router: router, factory: coordinatorFactory)
    }
}
