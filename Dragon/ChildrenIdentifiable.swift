//
//  ChildrenIdentifiable.swift
//  Dragon
//
//  Created by Michael Fourre on 12/11/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol ChildrenIdentifiable
{
    
}

extension ChildrenIdentifiable where Self: AnyObject
{
    static func getChildren() -> [Self.Type]
    {
        guard let defaults = UserDefaults.standard.object(forKey: "\(getClassName()).children") as? NSArray else
        {
            let classes = getChildClasses()
            //Initial lookup is moderately slow; store for faster lookup later
            UserDefaults.standard.set((classes.map({ NSStringFromClass($0) })) as NSArray, forKey: "\(getClassName()).children")
            return classes
        }
        var classes: [Self.Type] = []
        for classEntry in defaults
        {
            if let entry = classEntry as? String, let type = NSClassFromString(entry) as? Self.Type
            {
                classes.append(type)
            }
        }
        return classes
    }
    
    fileprivate static func getClassName() -> String
    {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    fileprivate static func getModuleName() -> String
    {
        return NSStringFromClass(self).components(separatedBy: ".").first ?? ""
    }
    
    fileprivate static func getChildClasses() -> [Self.Type]
    {
        let name = getClassName()
        let module = getModuleName()
        guard let defaults = UserDefaults.standard.object(forKey: "objc_getClassList") as? NSArray else
        {
            //We should only enter this block once
            let expectedCount = objc_getClassList(nil, 0)
            let classesPointer = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedCount))
            let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(classesPointer)
            let finalCount = Int(objc_getClassList(autoreleasingClasses, expectedCount))
            var defaults: [NSString] = []
            var classes: [Self.Type] = []
            for i in 0..<finalCount
            {
                if let classEntry: AnyClass = classesPointer[i]
                {
                    defaults.append(NSStringFromClass(classEntry) as NSString)
                    if let last = defaults.last as? String,
                        last.contains(module),
                        let validClass = classEntry as? Self.Type,
                        last != NSStringFromClass(self)
                    {
                        classes.append(validClass)
                    }
                }
            }
            classesPointer.deallocate(capacity: Int(expectedCount))
            //Initial lookup is slow, so store it for faster retrieval later
            UserDefaults.standard.set(defaults as NSArray, forKey: "objc_getClassList")
            Log.info("Found classes inheriting from \(name): \(classes)")
            return classes
        }
        
        var classes: [Self.Type] = []
        for i in 0..<defaults.count
        {
            if let classString = defaults[i] as? String,
                classString.contains(module),
                let classEntry = NSClassFromString(classString),
                let classType = classEntry as? Self.Type,
                classString != NSStringFromClass(self)
            {
                classes.append(classType)
            }
        }
        Log.info("Found classes inheriting from \(name): \(classes)")
        return classes
    }
}
