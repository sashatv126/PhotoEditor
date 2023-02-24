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
    
    var cameraService: CameraMock!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        cameraService = CameraMock()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        cameraService = nil
    }
    
    func testCreateLayer() {
        cameraService.startSession {
            XCTAssertEqual(true, self.cameraService.createLayer)
        }
    }
    
    func testStartSession() {
        cameraService.startSession {}
        XCTAssertEqual(true, cameraService.startSession)
    }

    func testGetPhoto() {
        cameraService.startSession { }
        cameraService.takePicture = true
        cameraService.photos += 1
        cameraService.takePicture = false
        XCTAssertEqual(1, cameraService.photos)
    }

}
