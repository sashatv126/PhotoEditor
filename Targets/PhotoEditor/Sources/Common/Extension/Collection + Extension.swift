//
//  Collection + Extension.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 12.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

