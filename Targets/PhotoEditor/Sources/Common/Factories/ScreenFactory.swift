//
//  ScreenFactory.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

protocol ScreenFactoryProtocol {
    func makeMainScreen() -> MainViewController
}

struct ScreenFactory: ScreenFactoryProtocol {
    func makeMainScreen() -> MainViewController {
        let viewModel = MainViewModel()
        let vc = MainViewController(viewModel: viewModel)
        return vc
    }
}


