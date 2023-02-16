//
//  RouteInstruction.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 13.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

enum RouteInstruction {
    case main
    
    static func setup() -> Self {
        return .main
    }
}
