//
//  ScreenFactory.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

enum Destination {
    case main
    case detailImage(delegate: UIViewControllerTransitioningDelegate)
}

protocol ScreenFactoryProtocol {
    func makeScreen(_ destination: Destination) -> UIViewController
}

struct ScreenFactory: ScreenFactoryProtocol {
    func makeScreen(_ destination: Destination) -> UIViewController {
        switch destination {
        case .main:
            return createMainScreen()
        case .detailImage(let delegate):
            return createDetailImageScreen(delegate: delegate)
        }
    }
}

extension ScreenFactory {
    private func createMainScreen() -> UIViewController {
        let cameraManager = CameraManager()
        let viewModel = MainViewModel(cameraAPI: cameraManager)
        let view = MainView()
        let vc = MainViewController(viewModel: viewModel, view: view)
        view.delegate = vc
        return vc
    }
    
    private func createDetailImageScreen(delegate: UIViewControllerTransitioningDelegate) -> UIViewController {
        let view = DetailImageView()
        let vc = DetailImageViewController(mainView: view)
        vc.transitioningDelegate = delegate
        return vc
    }
}


