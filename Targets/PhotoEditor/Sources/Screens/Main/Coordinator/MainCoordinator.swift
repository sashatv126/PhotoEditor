//
//  MainCoordinator.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

protocol MainFlowOutput {
    var flowOutput: HandlerVoid? { get set }
}

final class MainCoordinator: BaseCoordinator, MainFlowOutput {
    var flowOutput: HandlerVoid?
    
    private let factory: ScreenFactoryProtocol
    private let router: Routable
    
    init(factory: ScreenFactoryProtocol, router: Routable) {
        self.router = router
        self.factory = factory
    }
}

extension MainCoordinator {
    private func perform() {
        let vc = factory.makeMainScreen()
        router.setRootModule(vc)
    }
}

extension MainCoordinator: Coordinatable {
    func start() {
        perform()
    }
}
