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
    static var children: [AnyClass] { get set }
}

extension ChildrenIdentifiable
{
    static func getChildren() -> [AnyClass]
    {
        let initialCount = objc_getClassList(nil, 0)
        let classesPointer = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(initialCount))
        let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass?>(classesPointer)
        let finalCount = objc_getClassList(autoreleasingClasses, initialCount)
        var classes = [AnyClass]()
        for i in 0..<finalCount
        {
            if let type = Self.Type.self as? AnyClass, let classEntry = classesPointer[Int(i)], classEntry.isSubclass(of: type)
            {
                classes.append(classEntry)
            }
        }
        return classes
    }
}
