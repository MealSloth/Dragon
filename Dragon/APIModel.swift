//
//  APIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class APIModel: NSObject, PrettyPrintable
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
    
    override func valueForKey(key: String) -> AnyObject?
    {
        return super.valueForKey(key)
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
        Log.Info("Finished initializing model with values:\n\(self.description)")
    }
}
