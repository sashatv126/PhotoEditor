//
//  MainView.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit
import PhotoEditorKit

final class MainViewController: UIViewController {
    private let viewModel: MainViewModelLogic
    private var mainView: MainView?
    private var dataSource: MainDataSourceProtocol?
    private var images: [Image] = []
    private var bag = DisposeBag()
    
    init(viewModel: MainViewModelLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        mainView = createMainView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataSource()
        viewModel.checkPermission()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startSession { [weak self] in
            self?.setupPreviewLayer()
        }
    }
    
    private func createMainView() -> MainView {
        let view = MainView()
        view.delegate = self
        return view
    }
    
    private func setupPreviewLayer(){
        guard let layer = viewModel.getPreviewLayer() else { return }
        view.layer.insertSublayer(layer, below: mainView?.switchCameraButton.layer)
        layer.frame = self.view.layer.frame
    }
    
    private func bind() {
        viewModel.ciImage?.bindAndFire({ [weak self] ciImage in
            guard let self = self else { return }
            let uiImage = UIImage(ciImage: ciImage)
            DispatchQueue.main.async {
                self.images.append(Image(image: uiImage))
                self.dataSource?.reloadData(model: self.images, animate: true)
                self.viewModel.takePicture(isGetted: false)
                self.scrollToLast()
            }
        }).disposed(by: bag)
    }
    
    private func createDataSource() {
        if let collection = mainView?.collection {
            dataSource = MainDataSource(collection: collection)
            dataSource?.reloadData(model: [], animate: true)
        }
    }
    
    private func scrollToLast() {
        mainView?.collection.scrollToItem(at: [0,images.count - 1], at: .centeredHorizontally, animated: true)
    }
}

extension MainViewController: MainViewPresent {
    func switchCamera() {
        
    }
    
    func captureImage() {
        viewModel.takePicture(isGetted: true)
    }
}
