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

protocol MainViewModelLogic {
    var ciImage: Observable<CIImage>? { get }
    
    func takePicture(isGetted: Bool)
    func checkPermission()
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer?
    func startSession(setupPreview: @escaping () -> ())
    func getImage()
}

final class MainViewModel:MainViewModelLogic {
    var ciImage: Observable<CIImage>? = Observable(CIImage())
    
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
        cameraAPI?.handler = { ciIBuffer in
            let ciImage = CIImage(cvImageBuffer: ciIBuffer)
            self.ciImage?.value = ciImage
        }
    }
}
