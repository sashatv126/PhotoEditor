//
//  Routable.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 13.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

//major protocol of all routing 
protocol Routable: Presentable {
    
    func present(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: HandlerVoid?)
    
    func popModule(animated: Bool)
    
    func dismissModule(animated: Bool, completion: HandlerVoid?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}
