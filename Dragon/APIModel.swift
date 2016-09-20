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
        return self.getPropertiesString(self)
    }
    
    init(json: Dictionary<String, AnyObject>)
    {
        super.init()
        self.initialize(json)
    }
    
    override func value(forKey key: String) -> Any?
    {
        return super.value(forKey: key)
    }
    
    func initialize(_ json: Dictionary<String, AnyObject>, skip: [String] = [])
    {
        for property in self.getProperties()
        {
            if !skip.contains(property)
            {
                self.setValue(json[FieldNameHelper.getServerName(forClientName: property)], forKey: property)
            }
        }
        Log.info("Finished initializing model with values:\n\(self.description)")
    }
}
