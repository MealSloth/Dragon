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
    
    //This should be overridden by a subclass if one wishes to use a converter other than FieldNameHelper
    //Optionally, each individual model can manually initialize itself if the server's naming conventions
    //are not consistent enough to use a generic converter
    func initialize(_ json: Dictionary<String, AnyObject>, skip: [String] = [])
    {
        self.initialize(json, skip: skip, using: FieldNameHelper.self)
    }
    
    func initialize<T: FieldNameConverter>(_ json: Dictionary<String, AnyObject>, skip: [String] = [], using: T.Type)
    {
        for property in self.getProperties()
        {
            if !skip.contains(property)
            {
                self.setValue(json[T.getServerName(forClientName: property)], forKey: property)
            }
        }
        Log.info("Finished initializing model with values: \(self.description)")
    }
}
