//
//  MainView.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

protocol MainViewPresent: AnyObject {
    func switchCamera()
    func captureImage()
}

final class MainView: UIView {
    weak var delegate: MainViewPresent?
    
    private(set) var switchCameraButton : UIButton = {
        let button = UIButton()
        let image = UIImage(named: "switchcamera")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) var captureImageButton: CaptureButton = {
        let button = CaptureButton()
        button.backgroundColor = .white
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        captureImageButton.layer.cornerRadius = captureImageButton.frame.width / 2
    }
    
    private(set) var collection: UICollectionView = {
        let layout = MainLayoutBuilder.createLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - SetUI
extension MainView {
    private func setupView(){
        backgroundColor = .black
        addSubviews(switchCameraButton,captureImageButton, collection)
        
        NSLayoutConstraint.activate([
            switchCameraButton.widthAnchor.constraint(equalToConstant: 30),
            switchCameraButton.heightAnchor.constraint(equalToConstant: 30),
            switchCameraButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            switchCameraButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            captureImageButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            captureImageButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            captureImageButton.widthAnchor.constraint(equalToConstant: 50),
            captureImageButton.heightAnchor.constraint(equalToConstant: 50),
            
            collection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            collection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collection.heightAnchor.constraint(equalTo: heightAnchor,multiplier: 0.25),
            collection.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.5,constant: -70)
        ])
        collection.backgroundColor = .clear
        switchCameraButton.addTarget(self, action: #selector(switchCamera(_:)), for: .touchUpInside)
        addTargets()
    }
    
    private func addTargets() {
        captureImageButton.handler = { [weak self] in
            self?.delegate?.captureImage()
        }
    }
}

//MARK: - Targets -
extension MainView {
    @objc
    private func switchCamera(_ sender: UIButton?){
        sender?.isUserInteractionEnabled = false
        delegate?.switchCamera()
        sender?.isUserInteractionEnabled = true
    }
}
