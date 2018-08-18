//
//  Home.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 28/04/2018.
//  Copyright © 2018 user130776. All rights reserved.
//

import UIKit
import FontAwesome_swift
class Home: UIViewController {

    
    @IBOutlet weak var continueBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         //navigationItem.title="Zurück"
        
        //change the bgriund color of the image
        //        let imageView = UIImageView()
        //        imageView.frame = CGRect(x:0, y:0, width:100, height:100)
        //        imageView.image = UIImage.fontAwesomeIcon(name: .playCircle, textColor: UIColor.white, size: CGSize(width:200, height:200), backgroundColor:UIColor.black)
        //        imageView.layer.borderWidth=1
        //        imageView.layer.masksToBounds = false
        //        imageView.layer.borderColor = UIColor.black.cgColor
        //        imageView.layer.cornerRadius = imageView.frame.height/2
        //        imageView.clipsToBounds = true
        
        // var imageView = UIImageView(UIImage(named:"image"):image
        
        var label = UILabel(frame: CGRect(x:0, y: 0,width: 80,height: 80))
        label.font = UIFont.fontAwesome(ofSize: 100)
        label.text = String.fontAwesomeIcon(code: "fa-play-circle")
       // label.text = String.fontA
        self.view.addSubview(label)

        continueBtn.backgroundColor = UIColor.white
  
//        continueBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 80)
//        continueBtn.setTitle(String.fontAwesomeIcon(name: .playCircle), for: .normal)
       continueBtn.layer.cornerRadius = 0.5*continueBtn.bounds.size.width
        continueBtn.clipsToBounds = true
        
         label.centerXAnchor.constraint(equalTo: continueBtn.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: continueBtn.centerYAnchor).isActive = true
          continueBtn.addSubview(label)
        //view.addSubview(continueBtn)
     
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
