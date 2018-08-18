//
//  ScaleImage.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 02/04/2018.
//  Copyright © 2018 user130776. All rights reserved.
//

import UIKit
extension UIImage {
//class ScaleImage: UIViewController {
    class func scaleImageToSize(img: UIImage, size: CGSize)->UIImage{
        
        UIGraphicsBeginImageContext(size)
        
        img.draw(in: CGRect(origin: .zero, size: size))
       let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
}
