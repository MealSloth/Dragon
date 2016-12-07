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
    
    required init(json: [String: Any])
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
    func initialize(_ json: [String: Any], skip: [String] = [])
    {
        self.initialize(json, skip: skip, using: FieldNameHelper.self)
    }
    
    func initialize<T: FieldNameConverter>(_ json: [String: Any], skip: [String] = [], using: T.Type)
    {
        for property in self.getProperties()
        {
            if !skip.contains(property)
            {
                let value = self.value(forKey: property)
                if let model = value as? APIModel //Recursively handle models
                {
                    let type = type(of: model)
                    if let model = getModel(model: json[T.getServerName(forClientName: property)] as? [String: Any], using: type)
                    {
                        self.setValue(model, forKey: property) //Finally, set the value
                        continue //Onto the next property
                    }
                }
                else if let models = value as? [APIModel] //Recursively handle arrays of models
                {
                    let type = type(of: models).Element.self
                    if let modelArray = getArrayOfModels(array: json[T.getServerName(forClientName: property)] as? [[String: Any]], using: type)
                    {
                        self.setValue(modelArray, forKey: property) //Finally, set the value
                        continue //Onto the next property
                    }
                }
                self.setValue(json[T.getServerName(forClientName: property)], forKey: property) //Run only if no `continue`
            }
        }
        Log.info("Finished initializing model with values: \(self.description)")
    }
    
    func getModel<T: APIModel>(model: [String: Any]?, using: T.Type?) -> T?
    {
        guard let apiModel = model else { return nil }
        return T(json: apiModel)
    }
    
    func getArrayOfModels<T: APIModel>(array: [[String: Any]]?, using: T.Type?) -> [T]?
    {
        guard let modelArray = array else { return nil }
        var models: [T] = []
        for i in 0..<modelArray.count
        {
            models.append(T(json: modelArray[i])) //Recursively initialize nested Models
        }
        return models
    }
}
