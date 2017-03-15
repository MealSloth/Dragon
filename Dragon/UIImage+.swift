//
//  UIImage+.swift
//  Dragon
//
//  Created by Michael Fourre on 8/2/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }
    
    static func from(blob: Blob?) -> UIImage? {
        guard let blob = blob else { return nil }
        let cacheID = "blob_\(blob.id ?? "")"
        if let image = UIImageCache.get(cacheID) {
            return image
        } else {
            let image = UIImage(url: URL(string: blob.url))
            UIImageCache.put(image, at: cacheID)
            return image
        }
    }
    
    static func from(url: URL?, completion: ((UIImage?) -> Void)?) {
        BackgroundQueue.async({ () -> Void in
            completion?(UIImage(url: url))
        })
    }
    
    static func from(blob: Blob?, completion: ((UIImage?) -> Void)?) {
        BackgroundQueue.async({ () -> Void in
            completion?(UIImage.from(blob: blob))
        })
    }
}
