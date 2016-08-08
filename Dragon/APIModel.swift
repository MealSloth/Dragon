//
//  APIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class APIModel: NSObject
{
    override var description: String {
        let string = self.getPropertiesString(self)
        return string
    }
    
    init(json: Dictionary<String, AnyObject>)
    {
        super.init()
        self.initialize(json)
    }
    
    func initialize(json: Dictionary<String, AnyObject>, skip: [String] = [])
    {
        for property in self.getProperties()
        {
            if !skip.contains(property)
            {
                self.setValue(json[FieldNameHelper.GetServerName(forClientName: property)], forKey: property)
            }
        }
    }
    
    func getProperties() -> [String]
    {
        return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
    }
    
    private func getPropertiesString(context: APIModel, depth: Int = 0) -> String
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
    
    private func getPropertyString(context: APIModel, property: String, string s: String = "", depth d: Int = 0) -> String
    {
        let depth: Int = d
        var string: String = s
        for _ in 0..<depth
        {
            string += "    "
        }
        if let newProp = context.valueForKey(property) as? APIModel
        {
            string += "\(property):\n\(self.getPropertiesString(newProp, depth: depth))"
        }
        else if let arr = context.valueForKey(property) as? [APIModel]
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