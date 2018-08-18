//
//  PreviewController.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 05/03/2018.
//  Copyright © 2018 user130776. All rights reserved.
//

import UIKit
import FontAwesome_swift

//var photo = [UInt8]() //original image chosen by user
var imageNSData = NSData()

var photoWidth = CGFloat()
var photoHeight = CGFloat()


class PreviewController: UIViewController {

  
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var photo: UIImageView!
    var imagee: UIImage!
//    let alert = UIAlertController(title:"",message: "",preferredStyle: .alert)
//    let titleFont:[String: AnyObject] = [NSFontAttributeName : UIFont(name: "AmericanTypeWriter", size: 18)!]
//    let messageFont:[String: AnyObject] = [NSFontAttributeName: UIFont(name: "HelveticaNeue-THin", size: 14)!]
//    let attributedTitle = NSMutableAttributedString (string: "")
    
    //let action1 = UIAlertAction(title:"", style:  )

    //let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewControllerWithIdentifier()
    
    @IBOutlet weak var useBtn: UIButton!
    @IBOutlet weak var retryBtn: UIButton!
    
    @IBOutlet weak var centerPopUpConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var popup: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //  navigationItem.title="Zurück"
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = background.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    background.addSubview(blurEffectView)
       // photo.addSubview(background)
         photo.image = self.imagee
        
        background.addSubview(photo)
        let image = photo.image

        
        //new icons
       
        
        let label = UILabel(frame: CGRect(x:0, y: 0,width: Int(useBtn.frame.width-15/100*useBtn.frame.width),height: Int(useBtn.frame.height-15/100*useBtn.frame.height)))
        label.font = UIFont.fontAwesome(ofSize: CGFloat(useBtn.frame.width))
        print("use BTN WIDTH: " , Int(useBtn.frame.width))
        print("use BTN HEIGHT: " , Int(useBtn.frame.height))
        
        print("Bounds width: " , CGFloat(useBtn.bounds.size.width))
        //+ 10/100 * useBtn.bounds.size.width
        label.text = String.fontAwesomeIcon(code: "fa-play-circle")
        self.view.addSubview(label)
        useBtn.backgroundColor = UIColor.white
        useBtn.layer.cornerRadius = 0.4*useBtn.bounds.size.width
        useBtn.clipsToBounds = true

        let imageIcon=UIImage.fontAwesomeIcon(name: .trashO, textColor: .white, size: CGSize(width: Int(retryBtn.frame.width-10), height:Int(retryBtn.frame.height-10)),backgroundColor:UIColor.black)
        let imageView = UIImageView(image:imageIcon)

        self.view.addSubview(imageView)
        retryBtn.backgroundColor = UIColor.black
        retryBtn.layer.cornerRadius = 0.4 * retryBtn.bounds.size.width
        retryBtn.clipsToBounds = true
        print("use BTN WIDTH: " , Int(retryBtn.frame.width))
        print("use BTN HEIGHT: " , Int(retryBtn.frame.height))
        
        
        useBtn.addSubview(label)
        retryBtn.addSubview(imageView)
        
        label.centerXAnchor.constraint(equalTo: useBtn.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: useBtn.centerYAnchor).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: retryBtn.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: retryBtn.centerYAnchor).isActive = true
        
        
        photoWidth = photo.bounds.size.width
        photoHeight = photo.bounds.size.height
        
      
        
    }
   
    @IBAction func useBtnAction(_ sender: Any) {
        
        
        imageNSData = UIImageJPEGRepresentation(imagee!,0.1)! as NSData
        
        if(imageNSData != nil){
            print("photo width",photo.image?.size.width)
            print("photo height",photo.image?.size.height)
            print("data not null")
            performSegue(withIdentifier: "ShowAnalyse", sender: self)
            
        }
        
    }
        @IBAction func retryBtnAction(_ sender: Any) {
            performSegue(withIdentifier: "backToCamera", sender: self)
        }

   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
     
       // centerPopUpConstraint.constant = 297
  
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Zurück"
          backItem.tintColor = .black
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

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
