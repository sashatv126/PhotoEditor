//
//  AppCoordinatorMock.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

final class AppCoordinatorMock: AppCoordinator {
    private(set) var startCallCount = 0
    private(set) var didAddCallCount = 0
    private(set) var didRemoveCallCount = 0
    
    override func start() {
        super.start()
        startCallCount += 1
    }
    
    override func addDependency(_ coordinator: Coordinatable) {
        super.addDependency(coordinator)
        didAddCallCount += 1
    }
    
    override func removeDependency(_ coordinator: Coordinatable?) {
        super.removeDependency(coordinator)
        didRemoveCallCount += 1
    }
}
