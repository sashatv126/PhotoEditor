//
//  Presentable.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 13.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

//which vc wil be presented
protocol Presentable {
    var toPresent: UIViewController? { get }
}

extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}
