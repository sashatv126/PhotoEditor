//
//  CameraManager.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import AVFoundation

protocol CameraManagerLogic {
    var handler: ((CVImageBuffer) -> Void)? { get set }
    var takePicture: Bool { get set }
   
    func checkPermission()
    func startSession(_ previewClosure: @escaping () -> ())
    func createCaptureLayer() -> AVCaptureVideoPreviewLayer
}

final class CameraManager: NSObject, CameraManagerLogic {
    internal var handler: ((CVImageBuffer) -> Void)?
    
    private var captureSession: AVCaptureSession!
    private let queue = DispatchQueue(label: "Camera", qos: .userInitiated, attributes: .concurrent)
    
    private var backCamera: AVCaptureDevice!
    private var frontCamera: AVCaptureDevice!
    private var backInput: AVCaptureInput!
    private var frontInput: AVCaptureInput!
    private var videoOutput: AVCaptureVideoDataOutput!
    var takePicture: Bool = false
    
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    func startSession(_ previewClosure: @escaping () -> ()) {
        queue.async { [self] in
            captureSession = AVCaptureSession()
            captureSession.beginConfiguration()
            settingPreset()
            setupInputs()
            DispatchQueue.main.async {
                previewClosure()
            }
            setupOutput()
            captureSession.commitConfiguration()
            captureSession.startRunning()
        }
    }
    
    func checkPermission() {
        let cameraAuthStatus =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
        case .authorized:
            return
        case .denied:
            abort()
        case .notDetermined:
            AVCaptureDevice.requestAccess(
                for: AVMediaType.video,
                completionHandler:
                    { (authorized) in
                        if(!authorized){
                            abort()
                        }
                    })
        case .restricted:
            abort()
        @unknown default:
            fatalError()
        }
    }
    
    func createCaptureLayer() -> AVCaptureVideoPreviewLayer {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        return previewLayer
    }
    
    func setupOutput() {
        videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            fatalError("could not add video output")
        }
        
        videoOutput.connections.first?.videoOrientation = .portrait
    }
}

extension CameraManager {
    private func settingPreset() {
        if self.captureSession.canSetSessionPreset(.photo) {
            self.captureSession.sessionPreset = .photo
        }
        self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
    }
    
    private func setupInputs() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            backCamera = device
        } else {
            fatalError("no back camera")
        }
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device
        } else {
            fatalError("no front camera")
        }
        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
            fatalError("could not create input device from back camera")
        }
        backInput = bInput
        if !captureSession.canAddInput(backInput) {
            fatalError("could not add back camera input to capture session")
        }
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            fatalError("could not create input device from front camera")
        }
        frontInput = fInput
        if !captureSession.canAddInput(frontInput) {
            fatalError("could not add front camera input to capture session")
        }
        captureSession.addInput(backInput)
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        //guard takePicture else  { return }
                
        
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        handler?(cvBuffer)
    }
}
