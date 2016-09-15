//
//  PrettyPrintable.swift
//  Dragon
//
//  Created by Michael Fourre on 9/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol PrettyPrintable
{
    func valueForKey(key: String) -> AnyObject?
}

extension PrettyPrintable
{
    func getProperties() -> [String]
    {
        return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
    }
    
    func getPropertiesString(context: PrettyPrintable, depth: Int = 0) -> String
    {
        var string: String = (depth == 0) ? "\n" : ""
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
    
    private func getPropertyString(context: PrettyPrintable, property: String, string s: String = "", depth d: Int = 0) -> String
    {
        let depth: Int = d
        var string: String = s
        for _ in 0..<depth
        {
            string += "    "
        }
        if let newProp = context.valueForKey(property) as? PrettyPrintable
        {
            string += "\(property):\n\(self.getPropertiesString(newProp, depth: depth))"
        }
        else if let arr = context.valueForKey(property) as? [PrettyPrintable]
        {
            if arr.count > 0
            {
                for model in arr
                {
                    string += model.getPropertiesString(model)
                }
            }
            else
            {
                string += "\(property): {}\n"
            }
        }
        else
        {
            string += "\(property): \(self.valueForKey(property))\n"
        }
        return string
    }
}
