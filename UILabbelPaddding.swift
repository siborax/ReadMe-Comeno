//
//  UILabbelPaddding.swift
//  
//
//  Created by Sebora on 19/04/2018.
//

import UIKit

class UILabbelPaddding: UILabel {
    let padding = UIEdgeInsets(top:10, left:10, bottom:10 ,right:10)
    override func drawText(in rect: CGRect){
        super.drawText(in: UIEdgeInsetsInsetRect(rect,padding))
    }
    override var intrinsicContentSize : CGSize{
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let height = superContentSize.height +padding.top +padding.bottom
        return CGSize(width: width, hieght: height)
    }

}
