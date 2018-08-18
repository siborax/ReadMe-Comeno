//
//  Model.swift
//  FaceFeaturesDetection
//
//  Created by Sebora on 22/09/2017.
//  Copyright © 2017 user130776. All rights reserved.
//

import Foundation

class Points {
  
    var name = String.self
    var type = Int64.self
    var x = Double.self
    var y = Double.self
    
    init(name: String)
    {
        name = String.self
        type = Int64.self
        x = Double.self
        y = Double.self
    
    }
    init(name: String, type: Int64, x: Double, y: Double){
    self.name = name
        self.type = type
        self.x = x
        self.y = y
    }

}

