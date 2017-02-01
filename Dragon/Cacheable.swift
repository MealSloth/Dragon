//
//  Cacheable.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

protocol Cacheable
{
    associatedtype K: AnyObject
    associatedtype V: AnyObject
    static var shared: NSCache<K, V> { get }
}

extension Cacheable
{
    static var cache: NSCache<K, V> {
        let nsc: NSCache<K, V> = NSCache<K, V>()
        nsc.name = self.name
        return nsc
    }
    
    static var name: String {
        return String(describing: self)
    }
    
    static func get(_ key: K?) -> V?
    {
        guard let key = key else { return nil }
        return self.shared.object(forKey: key)
    }
    
    static func put(_ object: V?, at key: K?)
    {
        guard let key = key, let obj = object else { return }
        self.shared.setObject(obj, forKey: key as K)
    }
}

extension Cacheable where K: NSNumber
{
    static func get(_ key: Int?) -> V?
    {
        return self.get(K(value: key ?? -1))
    }
    
    static func put(_ object: V?, at key: Int?)
    {
        self.put(object, at: K(value: key ?? -1))
    }
}

extension Cacheable where K: NSString
{
    static func get(_ key: String?) -> V?
    {
        return self.get(K(string: key ?? ""))
    }
    
    static func put(_ object: V?, at key: String?)
    {
        self.put(object, at: K(string: key ?? ""))
    }
}
