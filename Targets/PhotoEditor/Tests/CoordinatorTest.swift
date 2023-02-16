//
//  CoordinatorTest.swift
//  PhotoEditorTests
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import XCTest
import UIKit.UINavigationController
@testable import PhotoEditor

final class CoordinatorTest: XCTestCase {
    
    private var coordinator: AppCoordinatorMock?

    override func setUpWithError() throws {
        try? super.setUpWithError()
        let factory = CoordinatorFactory()
        let router = Router(rootController: UINavigationController())
        coordinator = AppCoordinatorMock(router: router, factory: factory)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        try? super.tearDownWithError()
    }

    func testFuncStart() {
        coordinator?.start()
        XCTAssertEqual(coordinator?.startCallCount, 1)
    }

    func testAdd() {
        let factory = CoordinatorFactory()
        let router = Router(rootController: UINavigationController())
        let child = AppCoordinatorMock(router: router, factory: factory)
        
        coordinator?.addDependency(child)
        
        XCTAssertEqual(coordinator?.didAddCallCount, 1)
        XCTAssertEqual(coordinator?.childCoordinators.count, 1)
    }

    func testRemove() {
        let factory = CoordinatorFactory()
        let router = Router(rootController: UINavigationController())
        let child = AppCoordinatorMock(router: router, factory: factory)
        
        coordinator?.removeDependency(child)
        
        XCTAssertEqual(coordinator?.didRemoveCallCount, 1)
        XCTAssertEqual(coordinator?.childCoordinators.count, 0)
    }
}



