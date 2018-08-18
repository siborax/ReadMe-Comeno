//
//  FirstCameraPreview.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 01/03/2018.
//  Copyright © 2018 user130776. All rights reserved.
//


import UIKit
import AVFoundation

class FirstCameraPreview: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
   
    
    override func viewDidLoad(){

        
        super.viewDidLoad()
    
      
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        //print("DidAppear ",markedFace)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
