//
//  Coordinatable.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 13.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

//main protocol of work Coordinator pattern
protocol Coordinatable: AnyObject {
    //major func to push new flow
    func start()
}

