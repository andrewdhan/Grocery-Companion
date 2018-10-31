//
//  CameraPreviewViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit
import AVFoundation

class CameraPreviewViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            self.setupCaptureSession()
            
        case .notDetermined: // The user has not yet been asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    self.setupCaptureSession()
                }
            }
            
        case .denied: // The user has previously denied access.
            return
        case .restricted: // The user can't grant access due to restrictions.
            return
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.startRunning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        captureSession.stopRunning()
    }
    
    func setupCaptureSession(){
        captureSession.beginConfiguration()
        let photoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: .unspecified)
        guard
            let photoDeviceInput = try? AVCaptureDeviceInput(device: photoDevice!),
            captureSession.canAddInput(photoDeviceInput)
            else { return }
        
        captureSession.addInput(photoDeviceInput)
        let photoOutput = AVCapturePhotoOutput()
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
        self.previewView.videoPreviewLayer.session = self.captureSession
    }
    let captureSession = AVCaptureSession()
    
    @IBOutlet weak var previewView: PreviewView!
}
