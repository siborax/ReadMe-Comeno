//
//  Results.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 07/10/2017.
//  Copyright © 2017 user130776. All rights reserved.
//

import UIKit
import FirebaseDatabase
class Results: UIViewController {
   
    let data = imageData as Data
    let xCrd = xPoints
    let yCrd = yPoints
    @IBOutlet weak var textToWrite: UITextView!
    
    //@IBOutlet weak var fromDb: UITextView!
    
    @IBOutlet weak var eyebrow_height: UITextView!
    @IBOutlet weak var eh_TextView: UITextView!
    
    @IBOutlet weak var shape_eyebrow: UITextView!
    @IBOutlet weak var se_TextView: UITextView!
    
    @IBOutlet weak var eye_distance: UITextView!
    @IBOutlet weak var ed_TextView: UITextView!
    
    @IBOutlet weak var nose_wings: UITextView!
    @IBOutlet weak var nw_TextView: UITextView!
    
    @IBOutlet weak var upper_lips: UITextView!
    @IBOutlet weak var ul_TextView: UITextView!
    
    @IBOutlet weak var lower_lips: UITextView!
    @IBOutlet weak var ll_TextView: UITextView!
    
    @IBOutlet weak var shape_face: UITextView!
    @IBOutlet weak var sf_TextView: UITextView!
    
    @IBOutlet weak var jawbone: UITextView!
    @IBOutlet weak var jawbone_TextView: UITextView!
    
    
    @IBOutlet weak var faceImage: UIImageView!
    var ref:DatabaseReference?
    var postData = [Double]()
    var databaseHandle : DatabaseHandle?
    var thresholdValue = Double()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceImage.image = nil
        
        view.layer.removeAllAnimations()
        faceImage.image = UIImage(data: Data(data))
        var widthRatio = faceImage.bounds.size.width / (faceImage.image?.size.width)!
        var heightRatio = faceImage.bounds.size.height/(faceImage.image?.size.height)!
        var scale =  widthRatio < heightRatio ? widthRatio : heightRatio
        var imageWidth = scale * (faceImage.image?.size.width)!
        var imageHeight = scale * (faceImage.image?.size.height)!
        
        //descriptions.lineBreakMode = .byWordWrapping
        // description_textLbl.numberOfLines = 0
        
        
        // var maximumLabelSize = CGSize(width:370,height:heightForView(text: calculationsDictionary))
        
        
        
        
        if(!(data.isEmpty)){
            for i in 0...121 {
                let  circlePath = UIBezierPath(arcCenter:  CGPoint( x: CGFloat(xCrd[i])*widthRatio , y: CGFloat (yCrd[i])*heightRatio ), radius: CGFloat(2), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
                
                let shapeLayer = CAShapeLayer()
                shapeLayer.frame = CGRect(x: faceImage.frame.origin.x, y: faceImage.frame.origin.y , width: imageWidth , height: imageHeight )
                shapeLayer.fillColor = UIColor.yellow.cgColor
                shapeLayer.lineWidth = 0.5
                shapeLayer.path = circlePath.cgPath
                
                view.layer.addSublayer(shapeLayer)
            }
        }
        
     
        //Retrieve the posts and listen for changes
        
  
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
     //ref = Database.database().reference()
        for item in textToDisplay{
            
            self.textToWrite.text?.append (contentsOf: item)
            //self.descriptions.text?.append
        }
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let backItem = UIBarButtonItem()
            backItem.title = "Zurück"
            backItem.tintColor = .black
            navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
        
//        for(name, value) in calculationsDictionary{
//             var textfromDb = ""
//            //eyebrow_height
//            if(name == "eyebrow_height"){
//                
//                databaseHandle = ref?.child("thresholds").child("eyebrow_height").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                       // self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                        // print("first threshold ",self.thresholdValue)
//                        self.eyebrow_height.text="\(name)\t"
//                        
//            if (value < self.thresholdValue) {
//               self.ref?.child("thresholds").child("eyebrow_height").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                //Take the text from the snapshot and add it to the text array
//                let textDb = snapshot.value as? String
//                print("text: ",textDb)
//                if let actualtext = textDb {
//                      textfromDb=textDb as! String
//                    self.eh_TextView.text=textfromDb
//                }
//              
//               })
//               
//               
//            }
//                else if (value == self.thresholdValue) {
//                    self.ref?.child("thresholds").child("eyebrow_height").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                        //Take the text from the snapshot and add it to the text array
//                        let textDb = snapshot.value as? String
//                        print("text: ",textDb)
//                        if let actualtext = textDb {
//                            textfromDb=textDb as! String
//                            self.eh_TextView.text=textfromDb
//                        }
//                        
//                    })
//                    
//                }
//            else if (value > self.thresholdValue) {
//                self.ref?.child("thresholds").child("eyebrow_height").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
//                    //Take the text from the snapshot and add it to the text array
//                    let textDb = snapshot.value as? String
//                    print("text: ",textDb)
//                    if let actualtext = textDb {
//                        textfromDb=textDb as! String
//                        self.eh_TextView.text=textfromDb
//                    }
//                    
//                })
//                
//                }
//        }
//               
//            })
//                
//            }
//            
//           //shape_eyebrow
//            if(name == "shape_eyebrow"){
//                shape_eyebrow.text="\(name)\t"
//                databaseHandle = ref?.child("thresholds").child("shape_eyebrow").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                        //self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                print("shape_eyebrow threshold value: ",self.thresholdValue)
//                if (value < self.thresholdValue) {
//                    self.ref?.child("thresholds").child("shape_eyebrow").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                        //Take the text from the snapshot and add it to the text array
//                        let textDb = snapshot.value as? String
//                        print("text: ",textDb)
//                        if let actualtext = textDb {
//                            textfromDb=textDb as! String
//                            self.se_TextView.text=textfromDb
//                        }
//                        
//                    })
//                    
//                }
//                else if (value == self.thresholdValue) {
//                    self.ref?.child("thresholds").child("shape_eyebrow").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                        //Take the text from the snapshot and add it to the text array
//                        let textDb = snapshot.value as? String
//                        print("text: ",textDb)
//                        if let actualtext = textDb {
//                            textfromDb=textDb as! String
//                            self.se_TextView.text=textfromDb
//                        }
//                        
//                    })
//                    
//                }
//                else if (value > self.thresholdValue) {
//                    self.ref?.child("thresholds").child("shape_eyebrow").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                        //Take the text from the snapshot and add it to the text array
//                        let textDb = snapshot.value as? String
//                        print("text: ",textDb)
//                        if let actualtext = textDb {
//                            textfromDb=textDb as! String
//                            self.se_TextView.text=textfromDb
//                        }
//                        
//                    })
//                    
//                }
//            }
//
//                })
//                
//    }
//            
//            //eye_distance
//            if(name == "eye_distance"){
//                
//                databaseHandle = ref?.child("thresholds").child("eye_distance").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                        // self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                        // print("first threshold ",self.thresholdValue)
//                        
//                        
//                        self.eye_distance.text="\(name)\t"
//                        if (value < self.thresholdValue) {
//                            self.ref?.child("thresholds").child("eye_distance").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ed_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                            
//                        }
//                        else if (value == self.thresholdValue) {
//                            self.ref?.child("thresholds").child("eye_distance").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ed_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                        else if (value > self.thresholdValue) {
//                            self.ref?.child("thresholds").child("eye_distance").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ed_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                    }
//                    
//                })
//                
//            }
//            
//            //nose_wings
//            if(name == "nose_wings"){
//                
//                databaseHandle = ref?.child("thresholds").child("nose_wings").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                        // self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                        // print("first threshold ",self.thresholdValue)
//                        
//                        
//                        self.nose_wings.text="\(name)\t"
//                        if (value < self.thresholdValue) {
//                            self.ref?.child("thresholds").child("nose_wings").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.nw_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                            
//                        }
//                        else if (value == self.thresholdValue) {
//                            self.ref?.child("thresholds").child("nose_wings").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.nw_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                        else if (value > self.thresholdValue) {
//                            self.ref?.child("thresholds").child("nose_wings").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.nw_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                    }
//                    
//                })
//                
//            }
//
//            //upper_lips
//            if(name == "upper_lips"){
//                
//                databaseHandle = ref?.child("thresholds").child("upper_lips").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                        // self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                        // print("first threshold ",self.thresholdValue)
//                        
//                        
//                        self.upper_lips.text="\(name)\t"
//                        if (value < self.thresholdValue) {
//                            self.ref?.child("thresholds").child("upper_lips").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ul_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                            
//                        }
//                        else if (value == self.thresholdValue) {
//                            self.ref?.child("thresholds").child("upper_lips").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ul_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                        else if (value > self.thresholdValue) {
//                            self.ref?.child("thresholds").child("upper_lips").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ul_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                    }
//                    
//                })
//                
//            }
//
//            //lower_lips
//            if(name == "lower_lips"){
//                
//                databaseHandle = ref?.child("thresholds").child("lower_lips").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                        // self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                        // print("first threshold ",self.thresholdValue)
//                        
//                        
//                        self.lower_lips.text="\(name)\t"
//                        if (value < self.thresholdValue) {
//                            self.ref?.child("thresholds").child("lower_lips").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ll_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                            
//                        }
//                        else if (value == self.thresholdValue) {
//                            self.ref?.child("thresholds").child("lower_lips").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ll_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                        else if (value > self.thresholdValue) {
//                            self.ref?.child("thresholds").child("lower_lips").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.ll_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                    }
//                    
//                })
//                
//            }
//
//            //shape_face
//            if(name == "shape_face"){
//                
//                databaseHandle = ref?.child("thresholds").child("shape_face").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                        // self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                        // print("first threshold ",self.thresholdValue)
//                        
//                        
//                        self.shape_face.text="\(name)\t"
//                        if (value < self.thresholdValue) {
//                            self.ref?.child("thresholds").child("shape_face").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.sf_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                            
//                        }
//                        else if (value == self.thresholdValue) {
//                            self.ref?.child("thresholds").child("shape_face").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.sf_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                        else if (value > self.thresholdValue) {
//                            self.ref?.child("thresholds").child("shape_face").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.sf_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                    }
//                    
//                })
//                
//            }
//            
//            //jawbone
//            if(name == "jawbone"){
//                
//                databaseHandle = ref?.child("thresholds").child("jawbone").child("thresholdValue").child("value").observe(.value, with: { (snapshot) in
//                    
//                    //Take the value from the snapshot and add it to the postData array
//                    let post = snapshot.value as? Double
//                    print("post: ",post)
//                    if let actualPost = post {
//                        self.postData.append(actualPost )
//                        // self.fromDb.text = String(actualPost)
//                        self.thresholdValue = post!
//                        // print("first threshold ",self.thresholdValue)
//                        
//                        
//                        self.jawbone.text="\(name)\t"
//                        if (value < self.thresholdValue) {
//                            self.ref?.child("thresholds").child("jawbone").child("Below normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.jawbone_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                            
//                        }
//                        else if (value == self.thresholdValue) {
//                            self.ref?.child("thresholds").child("jawbone").child("Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.jawbone_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                        else if (value > self.thresholdValue) {
//                            self.ref?.child("thresholds").child("jawbone").child("Above Normal").child("text").observe(.value, with: { (snapshot) in
//                                //Take the text from the snapshot and add it to the text array
//                                let textDb = snapshot.value as? String
//                                print("text: ",textDb)
//                                if let actualtext = textDb {
//                                    textfromDb=textDb as! String
//                                    self.jawbone_TextView.text=textfromDb
//                                }
//                                
//                            })
//                            
//                        }
//                    }
//                    
//                })
//                
//            }
//            //
//            
//        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
