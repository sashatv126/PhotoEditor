//
//  Configurable.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 17.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

typealias ReusableCell = Configurable & UICollectionViewCell

protocol Configurable {
    associatedtype Model
    func configure(_ model: Model)
}
