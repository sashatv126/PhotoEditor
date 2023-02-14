//
//  BaseCoordinator.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 13.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

class BaseCoordinator {
    
    var childCoordinators: [Coordinatable] = []
        
    //only unique object
    func addDependency(_ coordinator: Coordinatable) {
        childCoordinators.forEach { element in
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    //remove object from coordinator
    func removeDependency(_ coordinator: Coordinatable?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator else { return }
        
        childCoordinators.enumerated().forEach { (index, element) in
            if element === coordinator {
                childCoordinators.remove(at: index)
                return
            }
        }
    }
}
