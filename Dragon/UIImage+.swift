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
        guard let url = URL(string: url), let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }
    
    class func from(url: String, completion: ((UIImage?) -> Void)?)
    {
        BackgroundQueue.async({ () -> Void in
            completion?(UIImage.from(url: url))
        })
    }
    
    class func from(blob: Blob?) -> UIImage?
    {
        guard let blob = blob else { return nil }
        let cacheID = "blob_\(blob.id ?? "")"
        let img = UIImageCache.get(cacheID) ?? UIImage.from(url: blob.url)
        UIImageCache.put(img, at: cacheID)
        return img
    }
    
    class func from(blob: Blob?, completion: ((UIImage?) -> Void)?)
    {
        BackgroundQueue.async({ () -> Void in
            completion?(UIImage.from(blob: blob))
        })
    }
}
