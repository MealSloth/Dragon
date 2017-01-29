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
        nsc.name = Self.name
        return nsc
    }
    
    static var name: String {
        return String(describing: Self.self)
    }
    
    static func get(_ key: K?) -> V?
    {
        guard let key = key else { return nil }
        return Self.shared.object(forKey: key)
    }
    
    static func put(_ object: V?, at key: K?)
    {
        guard let key = key, let obj = object else { return }
        Self.shared.setObject(obj, forKey: key as K)
    }
}

extension Cacheable where K: NSString
{
    static func get(_ key: String?) -> V?
    {
        return Self.get(K(string: key ?? ""))
    }
    
    static func put(_ object: V?, at key: String?)
    {
        Self.put(object, at: K(string: key ?? ""))
    }
}
