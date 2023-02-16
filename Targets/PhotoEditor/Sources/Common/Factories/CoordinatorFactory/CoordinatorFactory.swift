//
//  CoordinatorFactory.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

final class CoordinatorFactory {
    private let screenFactory = ScreenFactory()
}

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainFlowOutput {
        return MainCoordinator(factory: screenFactory, router: router)
    }
}
