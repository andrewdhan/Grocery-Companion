//
//  CameraPreviewViewController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import UIKit
import CoreImage
import AVFoundation

protocol CameraPreviewViewControllerDelegate: class {
    func didFinishProcessingImage(image: CGImage)
}

class CameraPreviewViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frames = [frameTL,frameTR,frameBR, frameBL]
        for frame in frames{
            frame.tintColor = UIColor.darkGray
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapScreen(_:)))
        self.previewView.addGestureRecognizer(tapGesture)
    }
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
    //MARK: - AVCapturePhotoCaptureDelegate Methods
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let photoData = photo.fileDataRepresentation(),
            let image = UIImage(data: photoData) else {
                NSLog("Error with photoData")
                return
        }
//        let croppedFrame = CGRect(x: 70, y: 80, width: image.size.width-140, height: image.size.height - 160)
//        let croppedImage = cropImage(image, toRect: croppedFrame, viewWidth: image.size.width-140, viewHeight: image.size.height-160)
//

//        scans.append(image)
//
        let croppedImage = image.cgImage!
        testView.image = UIImage(cgImage: croppedImage)
        delegate?.didFinishProcessingImage(image: croppedImage)
        
    }
    //MARK: - Private Methods
    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
    {
        let imageViewScale = max(inputImage.size.width / viewWidth,
                                 inputImage.size.height / viewHeight)
        
        // Scale cropRect to handle images larger than shown-on-screen size
        let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                              y:cropRect.origin.y * imageViewScale,
                              width:cropRect.size.width * imageViewScale,
                              height:cropRect.size.height * imageViewScale)
        
        // Perform cropping in Core Graphics
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
            else {
                return nil
        }
        
        // Return image to UIImage
        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        return croppedImage
    }
    
    
    @objc func tapScreen(_ sender: Any?) {
        let photoSetting = AVCapturePhotoSettings()
        self.photoOutput.capturePhoto(with: photoSetting, delegate: self)
    }
    
    private func setupCaptureSession(){
        captureSession.beginConfiguration()
        let photoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                  for: .video, position: .unspecified)
        guard
            let photoDeviceInput = try? AVCaptureDeviceInput(device: photoDevice!),
            captureSession.canAddInput(photoDeviceInput)
            else { return }
        
        captureSession.addInput(photoDeviceInput)
        
        guard captureSession.canAddOutput(photoOutput) else { return }
        captureSession.sessionPreset = .photo
        captureSession.addOutput(photoOutput)
        captureSession.commitConfiguration()
        self.previewView.videoPreviewLayer.session = self.captureSession
    }
    
    //MARK: - Properties
    weak var delegate: CameraPreviewViewControllerDelegate?
    
    
    let captureSession = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    
    var scans = [UIImage]()
    
    @IBOutlet weak var testView: UIImageView!
    private var frames = [UIImageView]()
    @IBOutlet weak var frameTL: UIImageView!
    @IBOutlet weak var frameTR: UIImageView!
    @IBOutlet weak var frameBR: UIImageView!
    @IBOutlet weak var frameBL: UIImageView!
    
    private let context = CIContext(options: nil)
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var previewView: PreviewView!
}
