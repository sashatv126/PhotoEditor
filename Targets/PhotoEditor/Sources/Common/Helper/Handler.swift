//
//  Handler.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 12.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

final class Handler<I,O> {
    var handle: ((I) -> (O))?
    
    init(handle: @escaping (I) -> (O)) {
        self.handle = handle
    }
}

