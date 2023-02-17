//
//  MainModel.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

struct OutputModel {
}

enum MainSections: Hashable {
    case images
}

struct Image: Hashable {
    static func == (lhs: Image, rhs: Image) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(image)
    }
    
    let image: UIImage
}
