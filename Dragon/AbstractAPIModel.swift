//
//  AbstractAPIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class AbstractAPIModel: NSObject, ReadableProperties
{
    init(json: Dictionary<String, AnyObject>)
    {
        super.init()
        self.initialize(json)
    }
    
    func initialize(json: Dictionary<String, AnyObject>)
    {
        for property in self.getProperties()
        {
            self.setValue(json[FieldNameHelper.GetServerName(forClientName: property)], forKey: property)
        }
//        preconditionFailure("This method must be overriden by the subclass.")
    }
}

protocol ReadableProperties
{
    func getProperties() -> [String]
}

extension ReadableProperties
{
    func getProperties() -> [String]
    {
        return Mirror(reflecting: self).children.filter { $0.label != nil }.map { $0.label! }
    }
}