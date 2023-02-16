//
//  AppCoordinator.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

class AppCoordinator: BaseCoordinator, Coordinatable {
    
    private let factory: CoordinatorFactoryProtocol
    private let router: Routable
    
    private var instructor: RouteInstruction {
        return RouteInstruction.setup()
    }
    
    init(router: Routable, factory: CoordinatorFactory) {
        self.router  = router
        self.factory = factory
    }
    
    func start() {
        switch instructor {
        case .main: performMainFlow()
        }
    }
}

extension AppCoordinator {
    func performMainFlow() {
        var coordinator = factory.makeMainCoordinator(router: router)
        coordinator.flowOutput = { [unowned self, unowned coordinator] in
            self.start()
            self.removeDependency(coordinator)
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
