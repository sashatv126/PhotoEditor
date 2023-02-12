//
//  RandomCollection + Extension.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 12.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

extension RandomAccessCollection {
    func element(at index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}

