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
    class func fromURL(_ url: String) -> UIImage?
    {
        if let nsurl = URL(string: url)
        {
            if let data = try? Data(contentsOf: nsurl)
            {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    class func fromURL(_ url: String, completion: ((UIImage?) -> Void)?)
    {
        AppDelegate.backgroundQueue.async {
            if let nsurl = URL(string: url)
            {
                if let data = try? Data(contentsOf: nsurl)
                {
                    completion?(UIImage(data: data))
                    return
                }
            }
            completion?(nil)
        }
    }
}
