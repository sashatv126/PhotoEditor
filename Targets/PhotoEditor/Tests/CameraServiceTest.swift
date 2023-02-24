//
//  CameraServiceTest.swift
//  PhotoEditorTests
//
//  Created by Александр Александрович on 24.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import XCTest
import AVFoundation.AVCaptureVideoPreviewLayer

@testable import PhotoEditor
final class CameraServiceTest: XCTestCase {
    
    var cameraService: CameraManagerLogic!

    override func setUpWithError() throws {
        cameraService = CameraManager()
    }

    override func tearDownWithError() throws {
        cameraService = nil
    }
    
    func testCheckPermission() {
        
    }
    
    func testCreateLayer() {
        cameraService.startSession {
            let layer = self.cameraService.createCaptureLayer()
            XCTAssertNil(layer)
        }
    }

    func testGetPhoto() {
        cameraService.startSession { }
        cameraService.takePicture = true
        cameraService.handler = { buffer in
            XCTAssertNotEqual(nil, buffer)
        }
        cameraService.takePicture = false
    }

}
