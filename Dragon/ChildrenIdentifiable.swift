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

extension ChildrenIdentifiable where Self: APIModel
{
    static func children() -> [APIModel.Type]
    {
        guard let defaults = UserDefaults.standard.object(forKey: "APIModel.children") as? NSArray else
        {
            let classes = getChildClasses()
            UserDefaults.standard.set((classes.map { NSStringFromClass($0) }) as NSArray, forKey: "APIModel.children")
            return classes
        }
        var classes: [APIModel.Type] = []
        for classEntry in defaults
        {
            if let entry = classEntry as? String, let type = NSClassFromString(entry) as? APIModel.Type
            {
                classes.append(type)
            }
        }
        return classes
        
    }
    
    fileprivate static func getChildClasses() -> [APIModel.Type]
    {
        let expectedCount = objc_getClassList(nil, 0)
        let classesPointer = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedCount))
        let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(classesPointer)
        let finalCount = Int(objc_getClassList(autoreleasingClasses, expectedCount))
        var classes = [APIModel.Type]()
        for i in 0..<finalCount
        {
            if let classEntry: AnyClass = classesPointer[Int(i)],
                String(describing: classEntry).contains("APIModel"),
                let classType = classEntry as? APIModel.Type,
                String(describing: classType) != "APIModel"
            {
                classes.append(classType)
            }
        }
        classesPointer.deallocate(capacity: Int(expectedCount))
        Log.info("Found classes inheriting from APIModel: \(classes)")
        return classes
    }
}
