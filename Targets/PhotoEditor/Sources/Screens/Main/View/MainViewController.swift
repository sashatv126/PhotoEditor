//
//  MainView.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    private let viewModel: MainViewModelLogic
    
    init(viewModel: MainViewModelLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
