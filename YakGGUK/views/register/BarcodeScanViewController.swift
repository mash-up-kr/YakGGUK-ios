//
//  BarcodeScanViewController.swift
//  YakGGUK
//
//  Created by juhee on 2018. 11. 25..
//  Copyright © 2018년 team1. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeScanViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    var overlayFrameView: UIView?
    
    private var captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private let supportedCodeTypes = [
        AVMetadataObject.ObjectType.qr,
        AVMetadataObject.ObjectType.upce,
        AVMetadataObject.ObjectType.code39,
        AVMetadataObject.ObjectType.code39Mod43,
        AVMetadataObject.ObjectType.code93,
        AVMetadataObject.ObjectType.code128,
        AVMetadataObject.ObjectType.ean8,
        AVMetadataObject.ObjectType.ean13,
        AVMetadataObject.ObjectType.aztec,
        AVMetadataObject.ObjectType.pdf417,
        AVMetadataObject.ObjectType.itf14,
        AVMetadataObject.ObjectType.interleaved2of5,
        AVMetadataObject.ObjectType.dataMatrix
    ]
    private var permissionGranted = false

    override func viewDidLoad() {
        super.viewDidLoad()
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            permissionGranted = true
        default:
            permissionGranted = false
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] didAllow in
                self?.permissionGranted = didAllow
            }
        }
        if overlayFrameView == nil {
            overlayFrameView = UIView()
            if let overlayFrameView = overlayFrameView {
                overlayFrameView.layer.borderColor = UIColor.green.cgColor
                overlayFrameView.layer.borderWidth = 2
                view.addSubview(overlayFrameView)
                view.bringSubviewToFront(overlayFrameView)
            }
        }
        navigationController?.setToolbarHidden(true, animated: false)
        setBackgroundGradientLayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !permissionGranted {
            
            let alert = UIAlertController(title: "설정에서 카메라 권한을 허용해 주세요.", message: nil, preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                    let url = URL(string: UIApplication.openSettingsURLString)
                    UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                })
            )
            present(alert, animated: true, completion: nil)
        } else {
            startCamera()
        }
    }
    // MARK: private function
    private func startCamera() {
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            #if DEBUG
            print("error in DEBUG")
            #else
            print("error in RELEASE")
            #endif
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
        } catch {
            let alert = UIAlertController(title: "설정에서 카메라 권한을 허용해 주세요.", message: nil, preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                    let url = URL(string: UIApplication.openSettingsURLString)
                    UIApplication.shared.open(url!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                })
            )
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = cameraView.layer.bounds
        cameraView.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
    }

    @IBAction func moveToSearchByName(_ sender: UIButton) {
         navigateSearchVC()
    }
    
    private func navigateSearchVC() {
        guard let nextVC: SearchMedicineViewController = storyboard?.instantiateViewController(withIdentifier: "search_by_name") as? SearchMedicineViewController else {
            return
        }
        
//        present(nextVC, animated: true, completion: nil)
//        var oldVCs = navigationController?.viewControllers
//        oldVCs!.removeLast()
//        oldVCs!.append(nextVC)

        navigationController?.setToolbarHidden(true, animated: false)
//        navigationController?.setViewControllers(oldVCs!, animated: true)
        
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        navigationController?.addBottomDismissTransition()
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
}
extension BarcodeScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.isEmpty {
            overlayFrameView?.frame = CGRect.zero
            return
        }
        
        guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            return
        }
        
        if supportedCodeTypes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
//            overlayFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                // TODO : 바코드 검색 기능
                let alertVC = UIAlertController(title: "검색 결과 없음", message: "바코드 검색 결과가 없습니다. 이름 검색 화면으로 이동합니다.", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { [weak self] _ in
                    self?.navigateSearchVC()
                }))
                
                present(alertVC, animated: true) { [weak self] in
                    self?.captureSession.stopRunning()
                }
            }
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
