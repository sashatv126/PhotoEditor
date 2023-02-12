//
//  Optional + Extension.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 12.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

//predicate matching
extension Optional {
    func matching(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let value = self else {
            return nil
        }

        guard predicate(value) else {
            return nil
        }
        return value
    }
}

//set to necessary view
extension Optional where Wrapped == UIView {
    mutating func get<T: UIView>(
        orSet expression: @autoclosure () -> T
    ) -> T {
        guard let view = self as? T else {
            let newView = expression()
            self = newView
            return newView
        }
        return view
    }
}

