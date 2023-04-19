//
//  MainCoordinator.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

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
        let vc = factory.makeScreen(.main)
        router.setRootModule(vc)
    }
}

extension MainCoordinator: Coordinatable {
    func start() {
        perform()
    }
    
    func openImage() {
        
    }
}
