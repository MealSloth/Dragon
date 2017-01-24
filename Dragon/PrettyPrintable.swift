//
//  PrettyPrintable.swift
//  Dragon
//
//  Created by Michael Fourre on 9/15/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation
import CoreData

protocol PrettyPrintable: PropertiesAccessible
{
    func value(for key: String) -> Any?
}

extension PrettyPrintable
{
    func getPropertiesString(_ context: PrettyPrintable, depth: Int = 0, nameless: Bool = false) -> String
    {
        var string: String = depth == 0 ? "\n\n" : ""
        string += nameless ? "{\n" : "\(Mirror(reflecting: self).subjectType): {\n"
        context.getProperties().forEach({ string += context.getPropertyString(context, property: $0, depth: depth + 1) })
        stride(from: 0, to: depth, by: 1).forEach({ _ in string += "    " })
        string += "}\n"
        return string
    }
    
    fileprivate func getPropertyString(_ context: PrettyPrintable, property: String, string s: String = "", depth d: Int = 0) -> String
    {
        let depth: Int = d
        var string: String = s
        stride(from: 0, to: depth, by: 1).forEach({ _ in string += "    " })
        
        if let newProp = context.value(for: property) as? PrettyPrintable
        {
            string += "\(property): \(newProp.getPropertiesString(newProp, depth: depth, nameless: true))"
            string.insert(",", at: string.index(before: string.endIndex))
        }
        else if let arr = context.value(for: property) as? [Any]
        {
            if arr.count > 0
            {
                string += "\(property): [\n"
                for element in arr
                {
                    stride(from: 0, through: depth, by: 1).forEach({ _ in string += "    " })
                    if let model = element as? PrettyPrintable
                    {
                        string += model.getPropertiesString(model, depth: depth + 1)
                        string.insert(",", at: string.index(before: string.endIndex))
                    }
                    else
                    {
                        string += "\(element),\n"
                    }
                }
                stride(from: 0, to: depth, by: 1).forEach({ _ in string += "    " })
                string += "],\n"
            }
            else
            {
                string += "\(property): []\n"
            }
        }
        else if let value = self.value(for: property)
        {
            string += "\(property): \(value),\n"
        }
        else
        {
            string += "\(property): nil,\n"
        }
        return string
    }
}
