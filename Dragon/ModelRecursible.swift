//
//  ModelRecursible.swift
//  Dragon
//
//  Created by Michael Fourre on 12/8/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol ModelRecursible: PrettyPrintable
{
    
}

extension ModelRecursible where Self: APIModel
{
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
                    if let model = getModel(model: json[T.getServerName(forClientName: property)] as? [String: Any], using: type, with: property)
                    {
                        self.setValue(model, forKey: property) //Finally, set the value
                    }
                }
                else if let values = value as? [Any] //Handle arrays
                {
                    if let _ = values.first as? APIModel //Recursively handle arrays of models
                    {
                        if let models = values as? [APIModel]
                        {
                            let type = type(of: models).Element.self
                            let modelArray = getArrayOfModels(array: json[T.getServerName(forClientName: property)] as? [Any], using: type, with: property)
                            self.setValue(modelArray, forKey: property) //Finally, set the value
                        }
                    }
                    else //Handle arrays of other types
                    {
                        self.setValue(json[T.getServerName(forClientName: property)], forKey: property)
                    }
                }
                else
                {
                    self.setValue(json[T.getServerName(forClientName: property)], forKey: property)
                }
            }
        }
        Log.info("Finished initializing model with values: \(self.description)")
    }
    
    func getArrayOfModels<T: APIModel>(array: [Any]?, using: T.Type?, with property: String) -> [T]
    {
        guard let modelArray = array else { return [] }
        var models: [T] = []
        for i in 0..<modelArray.count
        {
            guard let dict = modelArray[safe: i] as? [String: Any],
                let model = getModel(model: dict, using: T.self, with: property) else
            {
                Log.warning("Failed attempting to parse a JSON array element as dictionary")
                return models
            }
            models.append(model)
        }
        return models
    }
    
    func getModel<T: APIModel>(model: [String: Any]?, using: T.Type?, with property: String) -> T?
    {
        guard let dict = model else { return nil }
        var value = self.value(forKey: property)
        if let array = value as? [APIModel], let element = array.first
        {
            value = element
        }
        if let _ = value as? AlbumAPIModel { return AlbumAPIModel(json: dict) as? T }
        if let _ = value as? BlobAPIModel { return BlobAPIModel(json: dict) as? T }
        if let _ = value as? ChefAPIModel { return ChefAPIModel(json: dict) as? T }
        if let _ = value as? ConsumerAPIModel { return ConsumerAPIModel(json: dict) as? T }
        if let _ = value as? LocationAPIModel { return LocationAPIModel(json: dict) as? T }
        if let _ = value as? OrderAPIModel { return OrderAPIModel(json: dict) as? T }
        if let _ = value as? OrderSummaryAPIModel { return OrderSummaryAPIModel(json: dict) as? T }
        if let _ = value as? OrderTimeAPIModel { return OrderTimeAPIModel(json: dict) as? T }
        if let _ = value as? PostAPIModel { return PostAPIModel(json: dict) as? T }
        if let _ = value as? ReviewAPIModel { return ReviewAPIModel(json: dict) as? T }
        if let _ = value as? UserAPIModel { return UserAPIModel(json: dict) as? T }
        if let _ = value as? UserLoginAPIModel { return UserLoginAPIModel(json: dict) as? T }
        return nil
    }
}
