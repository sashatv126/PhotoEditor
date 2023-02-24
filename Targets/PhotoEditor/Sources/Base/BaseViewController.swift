//
//  BaseViewController.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 24.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    internal var mainView: View!
    
    init(mainView: View) {
        super.init(nibName: nil, bundle: nil)
        self.mainView = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
}
