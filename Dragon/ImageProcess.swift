//
//  ImageProcess.swift
//  Dragon
//
//  Created by Hongyi on 16/3/24.
//  Copyright © 2016年 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class ImageProcess {
    
    class func makeRoundImage(image: UIImageView) {
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.whiteColor().CGColor
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    
}