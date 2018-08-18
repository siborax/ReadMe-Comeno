//
//  Descriptions.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 19/04/2018.
//  Copyright © 2018 user130776. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseDatabase

var textToDisplay = [String]()

class Descriptions: UIViewController {
    
    
    @IBOutlet weak var continueBtn: UIButton!
let data = imageData as Data
    let xCrd = xPoints
    let yCrd = yPoints
    
    
    @IBOutlet weak var faceimage: UIImageView!
    
    @IBOutlet weak var descriptions: UITextView!
    //@IBOutlet weak var description_textLbl: UITextView!
    @IBOutlet weak var titleLbl: UILabbelPaddding!
    
    var ref:DatabaseReference?
    var postData = [Double]()
    var databaseHandle : DatabaseHandle?
    var thresholdValue = Double()
    var textDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceimage.image = nil
        view.layer.removeAllAnimations()
        
        faceimage.image = UIImage(data: Data(data))
        var widthRatio = faceimage.bounds.size.width / (faceimage.image?.size.width)!
        var heightRatio = faceimage.bounds.size.height/(faceimage.image?.size.height)!
        var scale =  widthRatio < heightRatio ? widthRatio : heightRatio
        var imageWidth = scale * (faceimage.image?.size.width)!
        var imageHeight = scale * (faceimage.image?.size.height)!
        
     print("image width form description",(faceimage.image?.size.width)!)
        
        print("continueBtn btn",continueBtn.frame.minX)
        print("continueBtn btn",continueBtn.frame.minY)
        let label = UILabel(frame: CGRect(x:0, y: 0,width: Int(continueBtn.frame.width-15/100*continueBtn.frame.width),height: Int(continueBtn.frame.height-15/100*continueBtn.frame.height)))
        label.font = UIFont.fontAwesome(ofSize: CGFloat(continueBtn.frame.width))
        label.text = String.fontAwesomeIcon(code: "fa-play-circle")
        self.view.addSubview(label)
        continueBtn.backgroundColor = UIColor.white
        continueBtn.layer.cornerRadius = 0.4*continueBtn.bounds.size.width
        continueBtn.clipsToBounds = true
        continueBtn.addSubview(label)
        
        
        label.centerXAnchor.constraint(equalTo: continueBtn.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: continueBtn.centerYAnchor).isActive = true
        
       // faceImage.image = nil
        //data.contentMode =  UIViewContentMode.scaleAspectFit
        // view.layer.removeAllAnimations()
        let viewWidth = faceimage.layer.frame.width
        let viewHeight = faceimage.layer.frame.height
        
  
        let xDistance = faceimage.frame.origin.x
        let yDistance = faceimage.frame.origin.y
        
      
        
        
        if(!(data.isEmpty)){
            for i in 0...121 {
            let  circlePath = UIBezierPath(arcCenter:  CGPoint( x: CGFloat(xCrd[i])*widthRatio , y: CGFloat (yCrd[i])*heightRatio ), radius: CGFloat(2), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
                
                let shapeLayer = CAShapeLayer()
                shapeLayer.frame = CGRect(x: faceimage.frame.origin.x, y: faceimage.frame.origin.y , width: imageWidth , height: imageHeight )
                shapeLayer.fillColor = UIColor.yellow.cgColor
                 shapeLayer.lineWidth = 0.5
                shapeLayer.path = circlePath.cgPath
                
                view.layer.addSublayer(shapeLayer)
            }
        }
        fillInDescriptions()
    }
   
    func fillInDescriptions(){
        ref = Database.database().reference()
        textToDisplay.removeAll()
        for(name, value) in calculationsDictionary{
            var textfromDb = ""
            //eyebrow_height
            if(name == "eyebrow_height"){
                
                databaseHandle = ref?.child("thresholds").child("eyebrow_height").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        // self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        // print("first threshold ",self.thresholdValue)
                        //self.eyebrow_height.text="\(name)\t"
                        textToDisplay.append("Eyebrow Height: " + String(value))
                        textToDisplay.append("\n")
                        
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("eyebrow_height").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                
                                }
                                
                            })
                            
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("eyebrow_height").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("eyebrow_height").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
            
            //shape_eyebrow
            if(name == "shape_eyebrow"){
                //shape_eyebrow.text="\(name)\t"
                databaseHandle = ref?.child("thresholds").child("shape_eyebrow").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        //self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        print("shape_eyebrow threshold value: ",self.thresholdValue)
                        
                        textToDisplay.append("Shape of the eyebrow: " + String(value))
                        textToDisplay.append("\n")
                        
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("shape_eyebrow").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("shape_eyebrow").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("shape_eyebrow").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
            
            //eye_distance
            if(name == "eye_distance"){
                
                databaseHandle = ref?.child("thresholds").child("eye_distance").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        // self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        // print("first threshold ",self.thresholdValue)
                        
                        
                        textToDisplay.append("Eye distance: " + String(value))
                        textToDisplay.append("\n")
                        
                       // self.eye_distance.text="\(name)\t"
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("eye_distance").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("eye_distance").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                  self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("eye_distance").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
            
            //nose_wings
            if(name == "nose_wings"){
                
                databaseHandle = ref?.child("thresholds").child("nose_wings").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        // self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        // print("first threshold ",self.thresholdValue)
                        
                       // textToDisplay["Nose Wings: "]=value
                        textToDisplay.append("Nose Wings: " + String(value))
                        textToDisplay.append("\n")
                        //self.nose_wings.text="\(name)\t"
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("nose_wings").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("nose_wings").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("nose_wings").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
            
            //upper_lips
            if(name == "upper_lips"){
                
                databaseHandle = ref?.child("thresholds").child("upper_lips").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        // self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        // print("first threshold ",self.thresholdValue)
                        
                        textToDisplay.append("Upper lips: " + String(value))
                        textToDisplay.append("\n")
                       // self.upper_lips.text="\(name)\t"
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("upper_lips").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("upper_lips").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("upper_lips").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
            
            //lower_lips
            if(name == "lower_lips"){
                
                databaseHandle = ref?.child("thresholds").child("lower_lips").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        // self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        // print("first threshold ",self.thresholdValue)
                        
                        textToDisplay.append("Lower lipps: " + String(value))
                        textToDisplay.append("\n")
                        //self.lower_lips.text="\(name)\t"
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("lower_lips").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("lower_lips").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("lower_lips").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
            
            //shape_face
            if(name == "shape_face"){
                
                databaseHandle = ref?.child("thresholds").child("shape_face").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        // self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        // print("first threshold ",self.thresholdValue)
                        
                        textToDisplay.append("Shape of the face: " + String(value))
                        textToDisplay.append("\n")
                      //  self.shape_face.text="\(name)\t"
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("shape_face").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("shape_face").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("shape_face").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                   self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
            
            //jawbone
            if(name == "jawbone"){
                
                databaseHandle = ref?.child("thresholds").child("jawbone").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
                    
                    //Take the value from the snapshot and add it to the postData array
                    let post = snapshot.value as? Double
                    print("post: ",post)
                    if let actualPost = post {
                        self.postData.append(actualPost )
                        // self.fromDb.text = String(actualPost)
                        self.thresholdValue = post!
                        // print("first threshold ",self.thresholdValue)
                        textToDisplay.append("Jawbone: " + String(value))
                        textToDisplay.append("\n")
                        
                       // self.jawbone.text="\(name)\t"
                        if (value < self.thresholdValue) {
                            self.ref?.child("thresholds").child("jawbone").child("Below normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                            
                        }
                        else if (value == self.thresholdValue) {
                            self.ref?.child("thresholds").child("jawbone").child("Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                        else if (value > self.thresholdValue) {
                            self.ref?.child("thresholds").child("jawbone").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
                                //Take the text from the snapshot and add it to the text array
                                let textDb = snapshot.value as? String
                                print("text: ",textDb)
                                if let actualtext = textDb {
                                    textfromDb=textDb as! String
                                    self.descriptions.text?.append(contentsOf: textfromDb)
                                    self.descriptions.text?.append("\n")
                                    self.descriptions.text?.append("\n")
                                }
                                
                            })
                            
                        }
                    }
                    
                })
                
            }
        }
       
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

