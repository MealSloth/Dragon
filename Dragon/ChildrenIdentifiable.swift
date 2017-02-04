//
//  ChildrenIdentifiable.swift
//  Dragon
//
//  Created by Michael Fourre on 12/11/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol ChildrenIdentifiable: ClassValidatable {
    
}

extension ChildrenIdentifiable where Self: AnyObject {
    static func getChildren() -> [Self.Type] {
        let name = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        guard let defaults = UserDefaults.standard.object(forKey: "\(name).children") as? NSArray else {
            let classes = getChildClasses()
            //Initial lookup is slow, so store it for faster retrieval later
            UserDefaults.standard.set((classes.map({ NSStringFromClass($0) })) as NSArray, forKey: "\(name).children")
            return classes
        }
        var classes: [Self.Type] = []
        for classEntry in defaults {
            guard let entry = classEntry as? String else { continue }
            guard let type = NSClassFromString(entry) as? Self.Type else { continue }
            classes.append(type)
        }
        return classes
    }
    
    fileprivate static func getChildClasses() -> [Self.Type] {
        let name = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        let module = NSStringFromClass(self).components(separatedBy: ".").first ?? ""
        guard let defaults = UserDefaults.standard.object(forKey: "objc_getClassList") as? NSArray else {
            //We should only enter this block once
            let expectedCount = objc_getClassList(nil, 0)
            let classesPointer = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedCount))
            let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(classesPointer)
            let finalCount = Int(objc_getClassList(autoreleasingClasses, expectedCount))
            var defaults: [NSString] = []
            var classes: [Self.Type] = []
            for i in 0..<finalCount {
                guard let classEntry: AnyClass = classesPointer[i] else { continue }
                defaults.append(NSStringFromClass(classEntry) as NSString)
                guard let classType = self.validClass(classEntry, in: module) else { continue }
                classes.append(classType)
            }
            classesPointer.deallocate(capacity: Int(expectedCount))
            //Initial lookup is slow, so store it for faster retrieval later
            UserDefaults.standard.set(defaults as NSArray, forKey: "objc_getClassList")
            Log.info("Found classes inheriting from \(name): \(classes)")
            return classes
        }
        
        var classes: [Self.Type] = []
        for i in 0..<defaults.count {
            let className: AnyClass? = NSClassFromString(defaults[i] as? String ?? "")
            guard let classType = self.validClass(className, in: module) else { continue }
            classes.append(classType)
        }
        Log.info("Found classes inheriting from \(name): \(classes)")
        return classes
    }
}
