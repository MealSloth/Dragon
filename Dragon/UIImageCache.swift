//
//  UIImageCache.swift
//  Dragon
//
//  Created by Michael Fourre on 10/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

class UIImageCache
{
    static var cache: NSCache<NSString, UIImage> = {
        let uiImageCache = NSCache<NSString, UIImage>()
        uiImageCache.name = "UIImageCache"
        return uiImageCache
    }()
    
    static func get(_ key: String?) -> UIImage?
    {
        if let string = key
        {
            return cache.object(forKey: NSString(string: string))
        }
        return nil
    }
    
    static func put(image: UIImage?, at key: String?)
    {
        if let string = key, let object = image
        {
            cache.setObject(object, forKey: NSString(string: string))
        }
    }
}
