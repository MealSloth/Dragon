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
    class func from(url: String) -> UIImage?
    {
        if let url = URL(string: url), let data = try? Data(contentsOf: url)
        {
            return UIImage(data: data)
        }
        return nil
    }
    
    class func from(url: String, completion: ((UIImage?) -> Void)?)
    {
        AppDelegate.backgroundQueue.async(execute: { () -> Void in
            if let url = URL(string: url), let data = try? Data(contentsOf: url)
            {
                completion?(UIImage(data: data))
                return
            }
            completion?(nil)
        })
    }
    
    class func from(blob: Blob?) -> UIImage?
    {
        if let blob = blob
        {
            let cacheID = "blob_\(blob.id)"
            if let cached = UIImageCache.get(cacheID)
            {
                return cached
            }
            else
            {
                let img = UIImage.from(url: blob.url)
                UIImageCache.put(image: img, at: cacheID)
                return img
            }
        }
        else
        {
            Log.error("UIImage.from(blob:) received nil Blob")
            return nil
        }
    }
}
