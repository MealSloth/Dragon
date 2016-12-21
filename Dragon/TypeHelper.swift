//
//  TypeHelper.swift
//  Dragon
//
//  Created by Michael Fourre on 12/20/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

class TypeHelper
{
    class func type(from property: String?, ofObject object: APIModel) -> String?
    {
        let children = Mirror(reflecting: object).children
        let expectedChildren = children.filter{$0.label?.components(separatedBy: ".").first == property}
        if let child = expectedChildren[safe: 0]?.value
        {
            let childType = String(describing: type(of: child))
            return childType.components(separatedBy: "<").last?.components(separatedBy: ">").first
        }
        return nil
    }
    
    class func type(from property: String?, ofObject object: Model) -> NSAttributeType?
    {
        return object.entity.attributesByName.filter{$0.key == property}.map{$0.value}[safe: 0]?.attributeType
    }
}
