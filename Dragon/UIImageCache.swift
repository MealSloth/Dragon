//
//  UIImageCache.swift
//  Dragon
//
//  Created by Michael Fourre on 10/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import UIKit

struct UIImageCache: Cacheable
{
    static var shared: NSCache<NSString, UIImage> = UIImageCache.cache
}
