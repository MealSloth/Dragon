//
//  AbstractAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class AbstractAPIModel: NSObject
{
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
}