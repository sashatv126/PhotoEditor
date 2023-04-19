//
//  DetailImageCoordinator.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.04.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

protocol DetailImageFlowOutput {
    var flowOutput: HandlerVoid? { get set }
}

final class DetailImageCoordinator: BaseCoordinator, DetailImageFlowOutput {
    var flowOutput: HandlerVoid?
    
    private let factory: ScreenFactoryProtocol
    private let router: Routable
    
    init(factory: ScreenFactoryProtocol, router: Routable) {
        self.router = router
        self.factory = factory
    }
}

extension DetailImageCoordinator {
    private func perform() {
    }
}

extension DetailImageCoordinator: Coordinatable {
    func start() {
        perform()
    }
}

extension DetailImageCoordinator: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return nil
        }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}


