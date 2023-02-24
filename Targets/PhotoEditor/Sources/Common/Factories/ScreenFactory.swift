//
//  ScreenFactory.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

protocol ScreenFactoryProtocol {
    func makeMainScreen() -> UIViewController
}

struct ScreenFactory: ScreenFactoryProtocol {
    func makeMainScreen() -> UIViewController {
        let cameraManager = CameraManager()
        let viewModel = MainViewModel(cameraAPI: cameraManager)
        let view = MainView()
        let vc = MainViewController(viewModel: viewModel, view: view)
        view.delegate = vc
        return vc
    }
}


