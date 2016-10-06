//
//  PrettyPrintable.swift
//  Dragon
//
//  Created by Michael Fourre on 9/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

protocol PrettyPrintable
{
    func value(forKey key: String) -> Any?
}

extension PrettyPrintable
{
    func getProperties() -> [String]
    {
        if let context = self as? NSManagedObject
        {
            return context.entity.attributesByName.map { $0.key }
        }
        else
        {
            return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
        }
    }
    
    func getPropertiesString(_ context: PrettyPrintable, depth: Int = 0) -> String
    {
        var string: String = (depth == 0) ? "\n\n" : ""
        string += "\(Mirror(reflecting: self).subjectType): {\n"
        for property in context.getProperties()
        {
            string += context.getPropertyString(context, property: property, depth: depth + 1)
        }
        for _ in 0..<depth
        {
            string += "    "
        }
        string += "}\n"
        return string
    }
    
    fileprivate func getPropertyString(_ context: PrettyPrintable, property: String, string s: String = "", depth d: Int = 0) -> String
    {
        let depth: Int = d
        var string: String = s
        for _ in 0..<depth
        {
            string += "    "
        }
        
        if let newProp = context.value(forKey: property) as? PrettyPrintable
        {
            string += "\(property):\n\(self.getPropertiesString(newProp, depth: depth))"
        }
        else if let arr = context.value(forKey: property) as? [PrettyPrintable]
        {
            if arr.count > 0
            {
                for model in arr
                {
                    string += model.getPropertiesString(model, depth: depth)
                }
            }
            else
            {
                string += "\(property): {}\n"
            }
        }
        else
        {
            if let value = self.value(forKey: property)
            {
                string += "\(property): \(value)\n"
            }
            else
            {
                string += "\(property): nil\n"
            }
        }
        return string
    }
}
