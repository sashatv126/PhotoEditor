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
    func switchCamera()
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
    internal var takePicture: Bool = false
    
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    enum CameraType {
        case front
        case back
    }
    
    private var currentCamera: CameraType = .front
    
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
            debugPrint("denied")
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
            debugPrint("restricted")
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
        videoOutput.alwaysDiscardsLateVideoFrames = true
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            fatalError("could not add video output")
        }
        
        videoOutput.connections.first?.videoOrientation = .portrait
    }
    
    func switchCamera() {
        captureSession.beginConfiguration()
        switch currentCamera {
        case .front:
            print(backInput, frontInput)
            captureSession.removeInput(backInput)
            captureSession.addInput(frontInput)
            currentCamera = .back
        case .back:
            print(backInput, frontInput)
            captureSession.removeInput(frontInput)
            captureSession.addInput(backInput)
            currentCamera = .front
        }
        videoOutput.connections.first?.videoOrientation = .portrait
        
        captureSession.commitConfiguration()
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
        }
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device
        }
        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else { return }
        backInput = bInput
        
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else { return }
        frontInput = fInput
        
        captureSession.addInput(backInput)
    }
}

extension CameraManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard takePicture else  { return }
        
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        handler?(cvBuffer)
    }
}
