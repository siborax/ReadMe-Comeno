//
//  CoordinatesViewController.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 03/10/2017.
//  Copyright © 2017 user130776. All rights reserved.
//

import UIKit
import AVFoundation

class CoordinatesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
 
//    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollImg: UIScrollView!
    
    var data = imageData as Data

    let xCrd = xPoints
    let yCrd = yPoints
    @IBOutlet weak var playBtn: UIButton!
     @IBOutlet weak var markedFace: UIImageView!
    var combinedImgView = UIImageView()
    
  //  @IBOutlet weak var center: NSLayoutConstraint!
    @IBAction func showResults(_ sender: Any) {
  
        
    }
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        markedFace.image = nil
         view.layer.removeAllAnimations()
        var img = UIImage(data:Data(data))
        markedFace.image=img
        
    scrollImg.delegate = self
        
        imageFrame(image: img!,inImageViewAspectFit: markedFace)
        print("Result frame", imageFrame)
        
        combinedImgView.frame =  imageFrame(image: img!,inImageViewAspectFit: markedFace)
        
        var widthRatio = markedFace.bounds.size.width / (img?.size.width)!;
        var heightRatio = markedFace.bounds.size.height / (img?.size.height)!;
       var scale = widthRatio < heightRatio ? widthRatio :heightRatio;
        var imageWidth = scale * ( img?.size.width)!;
        var imageHeight = scale * (img?.size.height)!;

       print(" image width",(img?.size.width)!*scale)
       
        //print("widthRatio: ",widthRatio)
       // print("heightRatio: ",heightRatio)
        print("Imagewidth: ",img?.size.width)
        print("IVwidthFrame: ",markedFace.frame.size.width)
        print("IVheight: ",img?.size.height)
         print("IVheightFrame: ",markedFace.frame.size.height)
       // print("IVFrame: ",markedFace.image?.height)
        
        
        print("w r: ",widthRatio)
        print("H R: ",heightRatio)
        
        print("Coordinates view scale", scale)
        
        //let viewWidth = markedFace.layer.frame.width
       // let viewHeight = markedFace.layer.frame.height
        
        let xDistance = markedFace.frame.origin.x
        let yDistance = markedFace.frame.origin.y
        
        //retry
        if(!(data.isEmpty)){
            for i in 0...121 {
                let  circlePath = UIBezierPath(arcCenter:  CGPoint( x: CGFloat(xCrd[i])*scale , y: CGFloat (yCrd[i])*scale), radius: CGFloat(2), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
                print("y: ", CGFloat(yCrd[i])*heightRatio)
                let shapeLayer = CAShapeLayer()
                shapeLayer.frame =  imageFrame(image:img!,inImageViewAspectFit: markedFace)
                shapeLayer.fillColor = UIColor.yellow.cgColor
                shapeLayer.lineWidth = 0.5
                shapeLayer.path = circlePath.cgPath

                markedFace.layer.addSublayer(shapeLayer)
               
            }
            scrollImg.addSubview(markedFace)
            
        }
        print("playBtn btn",playBtn.frame.minX)
        print("playBtn btn",playBtn.frame.minY)
        let label = UILabel(frame: CGRect(x:0, y: 0,width: Int(playBtn.frame.width-15/100*playBtn.frame.width),height: Int(playBtn.frame.height-15/100*playBtn.frame.height)))
        label.font = UIFont.fontAwesome(ofSize: CGFloat(playBtn.frame.width))
        label.text = String.fontAwesomeIcon(code: "fa-play-circle")
        self.view.addSubview(label)
        playBtn.backgroundColor = UIColor.white
        playBtn.layer.cornerRadius = 0.4*playBtn.bounds.size.width
        playBtn.clipsToBounds = true
        playBtn.addSubview(label)
        
        
        label.centerXAnchor.constraint(equalTo: playBtn.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: playBtn.centerYAnchor).isActive = true
   
    }
    
    func imageFrame(image: UIImage, inImageViewAspectFit imageView: UIImageView) -> CGRect {
        print("inside func")
        let imageRatio = (image.size.width / image.size.height)
        print("inside func 1",imageRatio)
        let viewRatio = imageView.frame.size.width / imageView.frame.size.height
        print("inside func 2",viewRatio)
        if imageRatio < viewRatio {
            let scale = imageView.frame.size.height / image.size.height
            print("scale1",scale)
            let width = scale * image.size.width
            let topLeftX = (imageView.frame.size.width - width) * 0.5
            print("width from func", width)
            return CGRect(x: topLeftX, y: 0, width: width, height: imageView.frame.size.height)
            
        } else {
            let scale = imageView.frame.size.width / image.size.width
             print("scale2",scale)
            let height = scale * image.size.height
            print("image height",height)
            print("imageview HEight: ",imageView.frame.size.height)
            let topLeftY = (imageView.frame.size.height - height) * 0.5
            print("yDistance", topLeftY)
            return CGRect(x: 0.0, y: 44.0, width: imageView.frame.size.width, height: height)
            
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?
    {
        //cannot accept a scrollview as a return value
        return self.markedFace
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
          backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
