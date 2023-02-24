//
//  MainView.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit
import PhotoEditorKit

final class MainViewController<View: MainView>: BaseViewController<MainView> {
    private let viewModel: MainViewModelLogic
    private var dataSource: MainDataSourceProtocol?
    private var images: [Image] = []
    private var bag = DisposeBag()
    
    init(viewModel: MainViewModelLogic, view: MainView) {
        self.viewModel = viewModel
        super.init(mainView: view)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
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
    
    private func setupPreviewLayer(){
        guard let layer = viewModel.getPreviewLayer() else { return }
        view.layer.insertSublayer(layer, below: mainView?.switchCameraButton.layer)
        layer.frame = self.view.layer.frame
    }
    
    private func bind() {
        viewModel.uIImage?.bindAndFire({ [weak self] uiimage in
            guard let self = self else { return }
            self.updateUI(img: uiimage) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.dataSource?.reloadData(model: self.images, animate: true)
                    self.scrollToLast()
                }
            }
            self.viewModel.takePicture(isGetted: false)
        }).disposed(by: bag)
    }
    
    private func updateUI(img: UIImage, completion: @escaping () -> ()) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.images.append(Image(image: img))
            completion()
        }
    }
    
    private func createDataSource() {
        if let collection = mainView?.collection {
            dataSource = MainDataSource(collection: collection)
            dataSource?.reloadData(model: [], animate: true)
        }
    }
    
    private func scrollToLast() {
        mainView?
            .collection
            .scrollToItem(at: [0,images.count - 1], at: .centeredHorizontally, animated: true)
    }
}

extension MainViewController: MainViewPresent {
    func switchCamera() {
        
    }
    
    func captureImage() {
        viewModel.takePicture(isGetted: true)
    }
}
