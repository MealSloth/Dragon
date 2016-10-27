//
//  Cache.swift
//  Dragon
//
//  Created by Michael Fourre on 10/26/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class Cache
{
    static var cache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "Cache"
        return cache
    }()
    
    static func get<T>(_ key: String?) -> T?
    {
        return cache.object(forKey: key as AnyObject) as? T
    }
    
    static func put(object: AnyObject?, at key: String?)
    {
        cache.setObject(object as AnyObject, forKey: key as AnyObject)
    }
}
