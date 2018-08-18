//
//  DrawExample.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 04/11/2017.
//  Copyright © 2017 user130776. All rights reserved.
//

import UIKit

class DrawExample: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.*/
    
    override func draw(_ rect: CGRect) {
        //context is the object used for drawing
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(3.0)
        context?.setStrokeColor(UIColor.purple.cgColor)
        
        //Create a path
        context!.move(to: CGPoint.init(x:50,y:60))
        context!.addLine(to: CGPoint.init(x:250,y:320))
        
        //Actually draw the path
        context!.strokePath()
    }
 

}
