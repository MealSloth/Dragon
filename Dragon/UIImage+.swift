//
//  UIImage+.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

extension UIImage
{
    class func fromURL(url: String) -> UIImage?
    {
        if let nsurl = NSURL(string: url)
        {
            if let data = NSData(contentsOfURL: nsurl)
            {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
