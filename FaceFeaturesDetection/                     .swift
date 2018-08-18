//
//  ViewController.swift
//  FaceFeaturesDetection
//
//  Created by user130776 on 9/7/17.
//  Copyright © 2017 user130776. All rights reserved.
//

import UIKit
import Foundation
import SafariServices
import MessageUI
import CoreData
import SwiftyJSON
import JavaScriptCore


var result = String()
var calculationsDictionary=[String: Double]()
var calculations = String()
var faceImageData = [UInt8]()// this is the cropped image retrieved from GetFaceImage
var name = String("bla")
var imageData = NSData()//this is picked image of uiimageview convreted to nsdata
var xArray = [Int]()
var yArray = [Int]()
var pickedImage = [UInt8]() //original image chosen by user
var ServerWidth  = CGFloat()
var ServerHeight  = CGFloat()
var angle = Int()

var xPoints = [Int]()
//cropped image x coordinates (now used for both versions)
var yPoints = [Int]()
//cropped image y coordinates(now used for both versions)

//var face_imageData=NSData()
var names = [String]()



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MFMailComposeViewControllerDelegate

{
    
    //@IBOutlet var progressView: UIProgressView!
   // var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var centerPopUpConstraint: NSLayoutConstraint!
    
    
   
   // @IBOutlet weak var vertically: NSLayoutConstraint!
    
    @IBOutlet weak var pickedImage: UIImageView!
   
    @IBOutlet weak var uploadImg: UIButton!
    
    let data = imageNSData as Data
    
   
 
    
    
    
    var Xeyebrow_left_bottom = Int()
    var Yeyebrow_left_bottom = Int()
    
    var Xeye_left_top_outer = Int()
    var Yeye_left_top_outer = Int()
    
    var Xeye_left_top = Int()
    var Yeye_left_top = Int()
    
    var Xeye_left_bottom = Int()
    var Yeye_left_bottom = Int()
    
    
    var Xeyebrow_right_top_inner = Int()
    var Yeyebrow_right_top_inner = Int()
    
    var Xeyebrow_right_top = Int()
    var Yeyebrow_right_top = Int()
    
    var Xeye_left_inner = Int()
    var Yeye_left_inner = Int()
    
    var Xeye_right_inner = Int()
    var Yeye_right_inner = Int()
    
    var Xeye_left_outer = Int()
    var Yeye_left_outer = Int()
    
    var Xnose_left_top_outer = Int()
    var Ynose_left_top_outer = Int()
    
    var Xnose_right_top_outer = Int()
    var Ynose_right_top_outer = Int()
    
    var Xtemple_left_4 = Int()
    var Ytemple_left_4 = Int()
    
    var Xtemple_right_4 = Int()
    var Ytemple_right_4 = Int()
    
    var Xmouth_top = Int()
    var Ymouth_top = Int()
    
    var Xmouth_inner_top = Int()
    var Ymouth_inner_top = Int()
    
    var Xmouth_left = Int()
    var Ymouth_left = Int()
    
    var Xmouth_right = Int()
    var Ymouth_right = Int()
    
    var Xmouth_bottom = Int()
    var Ymouth_bottom = Int()
    
    var Xforehead_middle = Int()
    var Yforehead_middle = Int()
    
    var Xchin_bottom = Int()
    var Ychin_bottom = Int()
    
    var Xchin_left_2 = Int()
    var Ychin_left_2 = Int()
    
    var Xmouth_inner_bottom = Int()
    var Ymouth_inner_bottom = Int()
    
    var Xchin_right_2 = Int()
    var Ychin_right_2 = Int()
    
    
   
  
    override func viewDidLoad(){
 super.viewDidLoad()
        
//        var label = UILabel(frame: CGRect(x:0, y: 0,width: 50,height: 50))
//        label.font = UIFont.fontAwesome(ofSize: 60)
//        label.text = String.fontAwesomeIcon(code: "fa-play-circle")
//        self.view.addSubview(label)
//        uploadImg.backgroundColor = UIColor.white
//        uploadImg.layer.cornerRadius = 0.5*uploadImg.bounds.size.width
//        uploadImg.clipsToBounds = true
//        uploadImg.addSubview(label)
//        label.centerXAnchor.constraint(equalTo: uploadImg.centerXAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: uploadImg.centerYAnchor).isActive = true
//
        pickedImage.image = UIImage(data: Data(data)) //image data from Preview Controller
        
        getResponses()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        view.addSubview(activityIndicator)
        //activityIndicator.color
        pickedImage?.alpha = 0.7
        activityIndicator.startAnimating()
        let transform = CGAffineTransform(scaleX: 3,y: 3)
        self.activityIndicator.transform = transform
        
        var labelText = UILabel(frame: CGRect(x: 0, y:0,width:200, height:400))
        labelText.center = CGPoint(x:180, y:285)
        labelText.numberOfLines=0
        labelText.textAlignment = .center
        labelText.text = "Read me analysiert"
        labelText.textColor = UIColor.white
         labelText.font =  labelText.font.withSize(25)
        self.view.addSubview(labelText)
       
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }
    
//    func createAlert (title: String, message: String){
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//        alert.addAction(UIAlertAction(title:"Yes", style: UIAlertActionStyle.default,handler:{(action)in
//            alert.dismiss(animated:true, completion: nil)
//        }))
//
//        alert.addAction(UIAlertAction(title:"No", style: UIAlertActionStyle.default,handler:{(action)in
//            alert.dismiss(animated:true, completion: nil)
//        }))
//        self.present(alert, animated:true, completion: nil)
//
//    }
//create context of javascript code
    
    func getResponses(){
        print("Get REsponses called!")
        //parameters for json file path
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let Image = pickedImage.image
        //let passedImage = UIImagePNGRepresentation(Image!) as! NSData
        imageData = UIImageJPEGRepresentation(Image!, 0.1)! as NSData
        print ("picked image data: ",pickedImage.image)
        // let strBase64:String = imageData.base64EncodedString(options: .lineLength64Characters)
        //print(strBase64)
        
        // the number of elements:
        let count = imageData.length / MemoryLayout<UInt8>.size
        
        // create array of appropriate length:
        var bytes = [UInt8](repeating: 0, count: count)
        
        // copy bytes into array
        imageData.getBytes(&bytes, length:count * MemoryLayout<UInt8>.size)
        
        let byteArray:NSMutableArray = NSMutableArray()
        
        for i in 0 ..< count
        {
            byteArray.add(NSNumber(value: bytes[i]))
        }
        
        
        //Post
        var resultt: [Int] = []
        let dispatchGroup = DispatchGroup()
        guard let myurl = URL(string:"https://www.betafaceapi.com/service_json_ssl.svc/UploadNewImage_File")else {return}
        dispatchGroup.enter()
        var request = URLRequest(url: myurl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let parameters = ["api_key":"d45fd466-51e2-4701-8da8-04351c872236",
                          "api_secret":"171e8465-f548-401d-b63b-caf0dc28df5f",
                          "detection_flags":"",
                          "imagefile_data":byteArray,
            "original_filename":"face1.jpeg"] as [String : Any]
        
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])else {return}
        
        request.httpBody = httpBody
          print("REQUEST: ", request)
        
        //GetImageInfo session
        let session = URLSession.shared
        let task = session.dataTask(with: request , completionHandler: { (data, response, error) in
            
            
            if let response = response {
                 print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    // print("first getImageInfo")
                    if let dictionary = json as? [String: Any]{
                        
                        
                        if var number = dictionary["img_uid"] as? String{
                            // print(number)
                            guard let getInfo_url = URL(string:"https://www.betafaceapi.com/service_json_ssl.svc/GetImageInfo")else {return}
                            var getImageInfoRequest = URLRequest(url: getInfo_url)
                            getImageInfoRequest.httpMethod = "POST"
                            getImageInfoRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                            let parametersGetInfo = ["api_key":"d45fd466-51e2-4701-8da8-04351c872236",
                                                     "api_secret":"171e8465-f548-401d-b63b-caf0dc28df5f",
                                                     "img_uid" : number]
                            
                            //the request for getInfo method
                            guard let getInfo_httpBody = try? JSONSerialization.data(withJSONObject: parametersGetInfo, options: [])else {return}
                            print("First RESPONSE RECEIVED")
                            //GetImageInfo session
                            getImageInfoRequest.httpBody = getInfo_httpBody
                            var session = URLSession.shared
                            let task = session.dataTask(with: getImageInfoRequest, completionHandler:{ (data, response, error) in
                                //print ("response: ",response)
                                if let data = data {
                                    do{
                                        if let json = try JSONSerialization.jsonObject(with: data,  options: []) as? [String: Any]{
                                            
                                            if let json = try? JSON(json:json){
                                                // print("Response", json["faces"] )
                                                // print("inside Faces")
                                                print ("json faces: ",json["faces"])
                                                if json["faces"] == nil
                                                {
                                                   // self.uploadImg.sendActions(for: .touchUpInside)
                                                    self.getResponses()
                                                }
                                                else
                                                {
                                                    
                                                    for item in json["faces"].arrayValue{
                                                        // let task = session.dataTask(with: getImageInfoRequest, completionHandler:{ (data, response, error) in
                                                        
                                                        
                                                        if (item["uid"] != nil){
                                                            let uid = item["uid"].string!
                                                            //GetFaceImage session
                                                            //this post method is called but none of its values is used by the app
                                                            //initially created for retrieving the coordinates in a cropped image
                                                            guard let getFaceImage_url = URL(string: "https://www.betafaceapi.com/service_json_ssl.svc/GetFaceImage") else {return}
                                                            var getFaceImageRequest = URLRequest(url:getFaceImage_url)
                                                            getFaceImageRequest.httpMethod = "POST"
                                                         
                                                            getFaceImageRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                                                            let parametersGetFaceImage = ["api_key":"d45fd466-51e2-4701-8da8-04351c872236",
                                                                                          "api_secret":"171e8465-f548-401d-b63b-caf0dc28df5f",
                                                                                          "face_uid" : uid ]
                                                           
                                                            guard let getFaceImage_httpBody = try? JSONSerialization.data(withJSONObject: parametersGetFaceImage,options:[])else{return}
                                                            
                                                            getFaceImageRequest.httpBody = getFaceImage_httpBody
                                                            let session = URLSession.shared
                                                            let task = session.dataTask(with:getFaceImageRequest , completionHandler: {(data, response, error)in
                                                                if let data = data{
                                                                  
                                                                    
                                                                    ServerWidth = CGFloat(item["width"].floatValue)
                                                                    ServerHeight = CGFloat(item["height"].floatValue)
                                                                    angle = item["angle"].int!
                                                       
                                                                    xPoints.removeAll()
                                                                    yPoints.removeAll()
                                                              
                                                                    for subitem in item["points"].arrayValue{
                                                                        
                                                                        names.append(subitem["name"].string!)
                                                                        //
                                                                        xPoints.append(subitem["x"].int!)
                                                                        yPoints.append(subitem["y"].int!)
                                                                        
                                                                        
                                                                        
                                                                    }
                                                                    for counter in 0...121 {
                                                                        print("X sent:", xPoints[counter], "Y sent: ", yPoints[counter])
                                                                        resultt.append(xPoints[counter])
                                                                    }
                                                                    
                                                                    dispatchGroup.leave()
                                                                    
                                                                    
                                                                  
                                                                    result.removeAll()
                                                                    for var i in 0...121{
                                                                        
                                                                        if names[i] == "eyebrow left bottom" {
                                                                            self.Xeyebrow_left_bottom = xPoints[i]
                                                                            //                                                 print(i,"-Xeyebrow_left_bottom",Xeyebrow_left_bottom)
                                                                            self.Yeyebrow_left_bottom =  yPoints[i]
                                                                            //                                                 print(i,"-Yeyebrow_left_bottom",Yeyebrow_left_bottom)
                                                                            result += "eyebrow left bottom:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeyebrow_left_bottom))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeyebrow_left_bottom))
                                                                            result.append("\n")
                                                                            
                                                                        }
                                                                        else if names[i] == "eye left top outer"{
                                                                            self.Xeye_left_top_outer = xPoints[i]
                                                                            //                                                    print(i,"-Xeye_left_top_outer",Xeye_left_top_outer)
                                                                            self.Yeye_left_top_outer = yPoints[i]
                                                                            //                                                    print(i,"-Yeye_left_top_outer",Yeye_left_top_outer)
                                                                            result += "eye left top outer:"
                                                                            result.append(" ")
                                                                            result.append(String(self.self.Xeye_left_top_outer))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeye_left_top_outer))
                                                                            result.append("\n")
                                                                            
                                                                            
                                                                        }
                                                                        else if names[i] == "eye left top"{
                                                                            self.Xeye_left_top =  xPoints[i]
                                                                            //                                                    print(i,"-Xeye_left_top",Xeye_left_top)
                                                                            self.Yeye_left_top  = yPoints[i]
                                                                            //                                                    print(i,"-Yeye_left_top",Yeye_left_top)
                                                                            result += "eye left top:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeye_left_top))
                                                                            result.append(", ")
                                                                            result.append(String(self.self.Yeye_left_top))
                                                                            result.append("\n")
                                                                        }
                                                                        else if names[i] == "eye left bottom"{
                                                                            self.Xeye_left_bottom  = xPoints[i]
                                                                            //                                                    print(i,"-Xeye_left_bottom", Xeye_left_bottom)
                                                                           self.Yeye_left_bottom = yPoints[i]
                                                                            //                                                     print(i,"-Yeye_left_bottom",Yeye_left_bottom)
                                                                            result += "eye left bottom:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeye_left_bottom))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeye_left_bottom))
                                                                            result.append("\n")
                                                                        }
                                                                        else if names[i] == "eyebrow right top inner" {
                                                                           self.Xeyebrow_right_top_inner = xPoints[i]
                                                                            //                                                      print(i,"-Xeyebrow_right_top_inner",Xeyebrow_right_top_inner)
                                                                            self.Yeyebrow_right_top_inner = yPoints[i]
                                                                            //                                                     print(i,"-Yeyebrow_right_top_inner",Yeyebrow_right_top_inner)
                                                                            
                                                                            result += "eyebrow right top inner:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeyebrow_right_top_inner))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeyebrow_right_top_inner))
                                                                            result.append("\n")
                                                                            
                                                                        }
                                                                        else if names[i] == "eyebrow right top" {
                                                                            self.Xeyebrow_right_top = xPoints[i]
                                                                            //                                                    print(i,"-Xeyebrow_right_top",Xeyebrow_right_top)
                                                                            self.Yeyebrow_right_top = yPoints[i]
                                                                            //                                                    print(i,"-Yeyebrow_right_top",Yeyebrow_right_top)
                                                                            result += "eyebrow right top:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeyebrow_right_top))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeyebrow_right_top))
                                                                            result.append("\n")
                                                                            
                                                                        }
                                                                            
                                                                        else if names[i] == "eye left inner" {
                                                                            self.Xeye_left_inner = xPoints[i]
                                                                            //                                                    print(i,"-Xeye left inner",Xeye_left_inner)
                                                                            self.Yeye_left_inner = yPoints[i]
                                                                            //                                                    print(i,"-Yeye_left_inner",Yeye_left_inner)
                                                                            
                                                                            result += "eye left inner:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeye_left_inner))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeye_left_inner))
                                                                            result.append("\n")
                                                                        }
                                                                        else if names[i] == "eye right inner" {
                                                                            self.Xeye_right_inner = xPoints[i]
                                                                            //                                                    print(i,"-Xeye right inner",Xeye_right_inner)
                                                                            self.Yeye_right_inner = yPoints[i]
                                                                            //                                                    print(i,"-Yeye_right_inner",Yeye_right_inner)
                                                                            
                                                                            result += "eye right inner:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeye_right_inner))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeye_right_inner))
                                                                            result.append("\n")
                                                                        }
                                                                        else if names[i] == "eye left outer" {
                                                                            self.Xeye_left_outer = xPoints[i]
                                                                            //                                                    print(i,"-Xeye left outer",Xeye_left_outer)
                                                                            self.Yeye_left_outer = yPoints[i]
                                                                            //                                                    print(i,"-Yeye_left_outer",Yeye_left_outer)
                                                                            
                                                                            result += "eye left outer:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xeye_left_outer))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yeye_left_outer))
                                                                            result.append("\n")
                                                                            
                                                                        }
                                                                        else if names[i] == "nose left top outer" {
                                                                            self.Xnose_left_top_outer = xPoints[i]
                                                                            //                                                    print(i,"-Xnose left top outer",Xnose_left_top_outer)
                                                                            self.Ynose_left_top_outer = yPoints[i]
                                                                            //                                                    print(i,"-Ynose_left_top_outer",Ynose_left_top_outer)
                                                                            
                                                                            result += "nose left top outer:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xnose_left_top_outer))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ynose_left_top_outer))
                                                                            result.append("\n")
                                                                        }
                                                                        else if names[i] == "nose right top outer" {
                                                                            self.Xnose_right_top_outer = xPoints[i]
                                                                            //                                                    print(i,"-Xnose right top outer",Xnose_right_top_outer)
                                                                            self.Ynose_right_top_outer = yPoints[i]
                                                                            //                                                    print(i,"-Ynose_right_top_outer",Ynose_right_top_outer)
                                                                            
                                                                            result += "nose right top outer:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xnose_right_top_outer))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ynose_right_top_outer))
                                                                            result.append("\n")
                                                                            
                                                                        }
                                                                        else if names[i] == "temple left 4" {
                                                                            self.Xtemple_left_4 = xPoints[i]
                                                                            //                                                    print(i,"-Xtemple left 4",Xtemple_left_4)
                                                                            self.Ytemple_left_4 = yPoints[i]
                                                                            //                                                    print(i,"-Ytemple_left_4",Ytemple_left_4)
                                                                            
                                                                            result += "temple left 4:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xtemple_left_4))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ytemple_left_4))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "temple right 4" {
                                                                            self.Xtemple_right_4 = xPoints[i]
                                                                            //                                                    print(i,"-Xtemple right 4",Xtemple_right_4)
                                                                            self.Ytemple_right_4 = yPoints[i]
                                                                            //                                                    print(i,"-Ytemple_right_4",Ytemple_right_4)
                                                                            
                                                                            result += "temple right 4:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xtemple_right_4))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ytemple_right_4))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "mouth top" {
                                                                            self.Xmouth_top = xPoints[i]
                                                                            //                                                    print(i,"-Xmouth top",Xmouth_top)
                                                                            self.Ymouth_top = yPoints[i]
                                                                            //                                                    print(i,"-Ymouth top",Ymouth_top)
                                                                            
                                                                            result += "mouth top:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xmouth_top))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ymouth_top))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "mouth inner top" {
                                                                            self.Xmouth_inner_top = xPoints[i]
                                                                            //                                                    print(i,"-Xmouth inner top",Xmouth_inner_top)
                                                                            self.Ymouth_inner_top = yPoints[i]
                                                                            //                                                    print(i,"-Ymouth inner top",Ymouth_inner_top)
                                                                            
                                                                            result += "mouth inner top:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xmouth_inner_top))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ymouth_inner_top))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "mouth left" {
                                                                            self.Xmouth_left = xPoints[i]
                                                                            //                                                    print(i,"-Xmouth left",Xmouth_left)
                                                                            self.Ymouth_left = yPoints[i]
                                                                            //                                                    print(i,"-Ymouth left",Ymouth_left)
                                                                            
                                                                            result += "mouth left:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xmouth_left))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ymouth_left))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "mouth right" {
                                                                            self.Xmouth_right = xPoints[i]
                                                                            //                                                    print(i,"-Xmouth right",Xmouth_right)
                                                                            self.Ymouth_right = yPoints[i]
                                                                            //                                                    print(i,"-Ymouth right",Ymouth_right)
                                                                            
                                                                            result += "mouth right:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xmouth_right))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ymouth_right))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "mouth bottom" {
                                                                            self.Xmouth_bottom = xPoints[i]
                                                                            //                                                    print(i,"-Xmouth  bottom",Xmouth_bottom)
                                                                           self.Ymouth_bottom = yPoints[i]
                                                                            //                                                    print(i,"-Ymouth_bottom",Ymouth_bottom)
                                                                            
                                                                            result += "mouth bottom:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xmouth_bottom))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ymouth_bottom))
                                                                            result.append("\n")
                                                                        }
                                                                        else if names[i] == "mouth inner bottom" {
                                                                            self.Xmouth_inner_bottom = xPoints[i]
                                                                            //                                                    print(i,"-Xmouth inner bottom",Xmouth_inner_bottom)
                                                                            self.Ymouth_inner_bottom = yPoints[i]
                                                                            //                                                    print(i,"-Ymouth_inner_bottom",Ymouth_inner_bottom)
                                                                            
                                                                            result += "mouth inner bottom:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xmouth_inner_bottom))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ymouth_inner_bottom))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "forehead middle" {
                                                                            self.Xforehead_middle = xPoints[i]
                                                                            //                                                    print(i,"-Xforehead middle",Xforehead_middle)
                                                                            self.Yforehead_middle = yPoints[i]
                                                                            //                                                    print(i,"-Yforehead middle",Yforehead_middle)
                                                                            
                                                                            result += "forehead middle:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xforehead_middle))
                                                                            result.append(", ")
                                                                            result.append(String(self.Yforehead_middle))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "chin bottom" {
                                                                            self.Xchin_bottom = xPoints[i]
                                                                            //                                                    print(i,"-Xchin bottom",Xchin_bottom)
                                                                            self.Ychin_bottom = yPoints[i]
                                                                            //                                                    print(i,"-Ychin bottom",Ychin_bottom)
                                                                            
                                                                            result += "chin bottom:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xchin_bottom))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ychin_bottom))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "chin left 2" {
                                                                            self.Xchin_left_2 = xPoints[i]
                                                                            //                                                    print(i,"-Xchin left 2",Xchin_left_2)
                                                                           self.Ychin_left_2 = yPoints[i]
                                                                            //                                                    print(i,"-Ychin left 2",Ychin_left_2)
                                                                            
                                                                            result += "chin left 2:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xchin_left_2))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ychin_left_2))
                                                                            result.append("\n")
                                                                        }
                                                                            
                                                                        else if names[i] == "chin right 2" {
                                                                            self.Xchin_right_2 = xPoints[i]
                                                                            //                                                    print(i,"-Xchin right 2",Xchin_right_2)
                                                                            self.Ychin_right_2 = yPoints[i]
                                                                            //                                                    print(i,"-Ychin right 2",Ychin_right_2)
                                                                            
                                                                            result += "chin right 2:"
                                                                            result.append(" ")
                                                                            result.append(String(self.Xchin_right_2))
                                                                            result.append(", ")
                                                                            result.append(String(self.Ychin_right_2))
                                                                            result.append("\n")
                                                                        }
                                                                        
                                                                        //                                                    print ("index: ",i)
                                                                    }
                                                                    
                                                                    // print("Yeyebrow_left_bottom ",Yeyebrow_left_bottom)
                                                                    //CALCULATIONS
                                                                    
                                                                    //1.eyebrow height--> (y1(eyebrow left bottom)-y2(eye left top outer))/y3(eye left top)-y4(eye left bottom)
                                                                    
                                                                    //let eyebrow_height = Int(Yeyebrow_left_bottom[0])
                                                                    // print("eyebrow_height",eyebrow_height)
                                                                    calculations.removeAll()
                                                                    calculationsDictionary.removeAll()
                                                                    let eyebrow_height = Swift.abs((Double(self.Yeyebrow_left_bottom) - Double(self.Yeye_left_top_outer))/(Double(self.Yeye_left_top) - Double(self.Yeye_left_bottom)))
                                                                    let eyebrow_heightR = Double(round(100*eyebrow_height)/100)
                                                                    print("eyebrow_height",eyebrow_heightR)
                                                                    calculations.append("eyebrow_height: ")
                                                                    calculations.append(String(eyebrow_heightR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["eyebrow_height"]=eyebrow_heightR
                                                                    
                                                                    
                                                                    //2.shape of eyebrow and slope of eyebrow y2-y1/x2-x1
                                                                    let shape_eyebrow = Swift.abs((Double(self.Yeyebrow_right_top) - Double(self.Yeyebrow_right_top_inner))/(Double(self.Xeyebrow_right_top) - Double(self.Xeyebrow_right_top_inner)))
                                                                    let shape_eyebrowR = Double(round(100*shape_eyebrow)/100)
                                                                    print("shape_eyebrow",shape_eyebrowR)
                                                                    calculations.append("shape_eyebrow: ")
                                                                    calculations.append(String(shape_eyebrowR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["shape_eyebrow"]=shape_eyebrowR
                                                                    
                                                                    //3.EYE DISTANCE compared to the width of the right eye
                                                                    let eye_distance = Swift.abs((Double(self.Xeye_left_inner) - Double(self.Xeye_right_inner)) / (Double(self.Xeye_left_inner) - Double(self.Xeye_left_outer)))
                                                                    let eye_distanceR = Double(round(100*eye_distance)/100)
                                                                    print("eye_distance",eye_distanceR)
                                                                    calculations.append("eye_distance: ")
                                                                    calculations.append(String(eye_distanceR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["eye_distance"]=eye_distanceR
                                                                    
                                                                    //4.NOSE WINGS
                                                                    let nose_wings = Swift.abs((Double(self.Xnose_left_top_outer) - Double(self.Xnose_right_top_outer)) / (Double(self.Xtemple_left_4) - Double(self.Xtemple_right_4)))
                                                                    let nose_wingsR = Double(round(100*nose_wings)/100)
                                                                    print("nose_wings", nose_wingsR)
                                                                    calculations.append("nose_wings: ")
                                                                    calculations.append(String(nose_wingsR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["nose_wings"]=nose_wingsR
                                                                    
                                                                    //5. UPPER LIPS
                                                                    let upper_lips = Swift.abs((Double(self.Ymouth_top) - Double(self.Ymouth_inner_top)) / (Double(self.Xmouth_left) - Double(self.Xmouth_right)) )
                                                                    let upper_lipsR = Double(round(100*upper_lips)/100)
                                                                    print("upper_lips",upper_lipsR)
                                                                    calculations.append("upper_lips: ")
                                                                    calculations.append(String(upper_lipsR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["upper_lips"]=upper_lipsR
                                                                    
                                                                    //6. LOWER LIPS
                                                                    let lower_lips = Swift.abs((Double(self.Ymouth_inner_bottom) - Double(self.Ymouth_bottom))/(Double(self.Xmouth_left) - Double(self.Xmouth_right)))
                                                                    let lower_lipsR = Double(round(100*lower_lips)/100)
                                                                    print("lower_lips",lower_lipsR)
                                                                    calculations.append("lower_lips: ")
                                                                    calculations.append(String(lower_lipsR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["lower_lips"]=lower_lipsR
                                                                    
                                                                    //7.SHAPE OF THE FACE
                                                                    let shape_face = Swift.abs((Double(self.Xtemple_left_4) - Double(self.Xtemple_right_4))/(Double(self.Yforehead_middle) - Double(self.Ychin_bottom)))
                                                                    let shape_faceR = Double(round(100*shape_face)/100)
                                                                    print("shape_face",shape_faceR)
                                                                    calculations.append("shape_face: ")
                                                                    calculations.append(String(shape_faceR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["shape_face"]=shape_faceR
                                                                    
                                                                    //8.JAWBONE
                                                                    let jawbone = Swift.abs((Double(self.Xchin_left_2) - Double(self.Xchin_right_2))/(Double(self.Xtemple_left_4) - Double(self.Xtemple_right_4)))
                                                                    let jawboneR = Double(round(100*jawbone)/100)
                                                                    print("jawbone",jawboneR)
                                                                    calculations.append("jawbone: ")
                                                                    calculations.append(String(jawboneR))
                                                                    calculations.append("\n")
                                                                    calculationsDictionary["jawbone"]=jawboneR
                                                                    
                                                                    
                                                                    
                                                                    //  print("Calculations: ",calculations)
                                                                    
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                            })//session.dataTask(with:getFaceImageRequest){
                                                            task.resume()
                                                        }
                                                    }//  for item in json["faces"].arrayValue{
                                                    
                                                } //open again
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                        
                                    catch{
                                        print("ERRORRR: ",error)}
                                }
                                guard error == nil else {
                                    print(error!)
                                    return
                                }
                                guard let responseData = data else {
                                    print("Did not receive data")
                                    return
                                }
                                
                            })
                            task.resume()
                        }
                    }
                    
                    
                }catch{
                    print(error)
                    // }
                    
                }
            }
            
        })
        task.resume()
        dispatchGroup.notify(queue: DispatchQueue.global()){
            // onCompleted?(resultt)
            print("GO to the next page")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(600) , execute: {
                
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "ShowR", sender: self)
                print("READYYYY")
            })
            
        }
    }
 
//    @IBAction func uploadImage(_ sender: AnyObject) {
//
//        getResponses()
//
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        view.addSubview(activityIndicator)
//        self.view.alpha = 0.4
//        activityIndicator.startAnimating()
//
//
//
//    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String: Any]){
        if let pImage = info[UIImagePickerControllerOriginalImage]as? UIImage{
           // pickedImage.contentMode = .scaleAspectFit
            pickedImage.image = pImage
        }
        picker.dismiss(animated: true, completion: nil);
        
        print("picked image size: ", pickedImage.image?.size)
        
    }
//    @IBAction func photoLibraryAction(_ sender: UIButton) {
//
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
//        {
//        let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
//            imagePicker.allowsEditing = false
//            self.present(imagePicker, animated: true, completion: nil)
//
//        }
//    }
    
//    @IBAction func saveAction(_ sender:
//        UIButton) {
//        let imageData = UIImageJPEGRepresentation(pickedImage.image!,0.1)
//        print("image data in save button", imageData)
//        let compressedImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil,nil,nil)
//        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
////        saveNotice()
//    }
    
    
    
//        func saveNotice(){
//
//        let alertController = UIAlertController (title: "Image Saved!", message: "Your picture was successfully saved.", preferredStyle: .alert )
//        let defaultAction = UIAlertAction(title: "OK", style: .default, handler:nil)
//       alertController.addAction(defaultAction)
//        present(alertController, animated:true, completion: nil)
//           // print("Inside saveNotice")
//
//    }
    override func viewDidAppear(_ animated: Bool) {
       //self.view.alpha = 0.2
        // centerPopUpConstraint.constant = 297
        print("APPEARDDD")
       // UIView.animate(withDuration: 0.1) {
        //self.view.layoutIfNeeded()
         //}
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
          backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
    
}


