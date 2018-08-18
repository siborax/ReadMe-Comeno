//
//  CameraViewController.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 01/03/2018.
//  Copyright © 2018 user130776. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIButton!
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var aspectRatio:CGFloat = 1.0
    
    var viewFinderHeight: CGFloat = 0.0
    var viewFinderWidth: CGFloat = 0.0
    var viewFinderMarginLeft: CGFloat = 0.0
    var viewFinderMarginTop: CGFloat = 0.0
    

    override func viewDidLoad() {
    super.viewDidLoad()
        
    setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
       // cameraButton.frame = CGRect(x:160, y: 100, width: 50, height: 50)
        cameraButton.layer.cornerRadius = 0.5 * cameraButton.bounds.size.width
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.borderWidth = 5
        cameraButton.clipsToBounds = true
        
        
    }

    func  setupCaptureSession(){
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        print("capture session")
    }
    func   setupDevice(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.unspecified)
        let devices = deviceDiscoverySession?.devices
        
        for device in devices! {
            if device.position == AVCaptureDevicePosition.back{
                backCamera = device
            }
            else if device.position == AVCaptureDevicePosition.front{
                frontCamera = device
            }
        }
        currentCamera = frontCamera
        
    }
    func   setupInputOutput(){
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    func    setupPreviewLayer(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        
    }
    func     startRunningCaptureSession(){
        captureSession.startRunning()
        //print("CaptureSession is called")
        //print( captureSession.startRunning())
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Setup your camera here...
//    }
//    func setSession(session:AVCaptureSession)->Void{
//        if screenWidth > screenHeight{
//            aspectRatio = screenHeight/screenWidth * aspectRatio
//            viewFinderWidth = screenWidth
//            viewFinderHeight = self.bounds.height * aspectRatio
//        }
//        (self.setupPreviewLayer());.session = session;
//        
//    }
    @IBAction func cameraButton(_ sender: Any) {
    print("button pressed0")
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! PreviewController
//            if (self.image != nil) {
                previewVC.imagee = self.image
            let backItem = UIBarButtonItem()
            backItem.title = "Zurück"
              backItem.tintColor = .black
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                //print()
              //  print("Description of the image")
               // print(previewVC.image.description)
            }
            
//        }
    }
  
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
         print("inside extension1")
        print(photo.fileDataRepresentation())
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
             print("inside extension")
             print(image)
        }
     
    }
}

