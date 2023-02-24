//
//  CameraMock.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 24.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
@testable import PhotoEditor

final class CameraMock: CameraManagerLogic {
    var permission = false
    var image: UIImage! = nil
    var startSession = false
    var createLayer = false
    var photos = 0
    
    var handler: ((CVImageBuffer) -> Void)?
    
    var takePicture: Bool = false
    
    func checkPermission() {
        permission = true
    }
    
    func startSession(_ previewClosure: @escaping () -> ()) {
        startSession = true
    }
    
    func createCaptureLayer() -> AVCaptureVideoPreviewLayer {
        if startSession {
            createLayer = true
        }
        return AVCaptureVideoPreviewLayer()
    }
}
