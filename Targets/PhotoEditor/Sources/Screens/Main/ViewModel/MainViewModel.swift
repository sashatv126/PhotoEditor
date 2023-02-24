//
//  ViewModel.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation
import AVFoundation
import CoreImage
import PhotoEditorKit
import UIKit

protocol MainViewModelLogic {
    var uIImage: Observable<UIImage>? { get }
    
    func takePicture(isGetted: Bool)
    func checkPermission()
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer?
    func startSession(setupPreview: @escaping () -> ())
    func getImage()
}

final class MainViewModel:MainViewModelLogic {
    var uIImage: Observable<UIImage>? = Observable(UIImage())
    
    private var cameraAPI: CameraManagerLogic?
    
    init(cameraAPI: CameraManagerLogic?) {
        self.cameraAPI = cameraAPI
        getImage()
    }
}

extension MainViewModel {
    func checkPermission() {
        cameraAPI?.checkPermission()
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        guard let layer = cameraAPI?.createCaptureLayer() else { return nil }
        return layer
    }
    
    func startSession(setupPreview: @escaping () -> ()) {
        cameraAPI?.startSession({
            setupPreview()
        })
    }
    
    func takePicture(isGetted: Bool) {
        cameraAPI?.takePicture = isGetted
    }
    
    func getImage() {
        cameraAPI?.handler = { [weak self] ciIBuffer in
            let ciImage = CIImage(cvImageBuffer: ciIBuffer)
            let uiImage = UIImage(ciImage: ciImage)
            let resizeImage = self?.resizeImage(image: uiImage, scale: 0.5)
            if let resizeImage = resizeImage {
                self?.uIImage?.value = resizeImage
            }
        }
    }
}

extension MainViewModel {
    private func resizeImage(image: UIImage, scale: CGFloat) -> UIImage {
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
        return resizedImage
    }
}
