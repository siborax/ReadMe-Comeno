//
//  SecondViewController.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 13.09.17.
//  Copyright © 2017 user130776. All rights reserved.
//

import UIKit
import SafariServices

class SecondViewController: UIViewController, SFSafariViewControllerDelegate
{

    @IBOutlet weak var myWebView: UIWebView!
    private var urlString:String = "https://betafaceapi.com/forms_json.html"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.loadRequest(URLRequest(url:URL(string: "https://betafaceapi.com/forms_json.html")!))
        //let svc = SFSafariViewController(url: NSURL(string: self.urlString)! as URL)
        //self.present(svc, animated: true, completion: nil)
             }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
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
