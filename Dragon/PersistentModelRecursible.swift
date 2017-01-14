//
//  PersistentModelRecursible.swift
//  Dragon
//
//  Created by Michael Fourre on 12/20/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol PersistentModelRecursible: PrettyPrintable
{
    
}

extension PersistentModelRecursible where Self: APIModel
{
    func getModelType(fromAPIModelType apiModelType: APIModel.Type) -> Model.Type?
    {
        let modelClassString = NSStringFromClass(apiModelType).replacingOccurrences(of: "APIModel", with: "")
        return Model.children.filter{NSStringFromClass($0) == modelClassString}.first
    }
    
    func initialize<T: FieldNameConverter>(_ json: [String:Any], skip: [String] = [], using: T.Type)
    {
        for property in self.getProperties() where !skip.contains(property) && !skip.contains(T.getServerName(forClientName: property))
        {
            var value: Any? = json[T.getServerName(forClientName: property)] //The default value is most common
            if let values = value as? [Any] //Handle arrays
            {
                if let type = TypeHelper.type(from: property, ofObject: self),
                    type.contains("APIModel") //Recursively handle arrays of models
                {
                    let apiModelType: APIModel.Type = APIModel.children.filter{type == String(describing: $0)}[0]
                    let modelType = self.getModelType(fromAPIModelType: apiModelType)
                    var apiModels: [APIModel] = []
                    for i in 0..<values.count
                    {
                        if let apiModel = apiModelType.init(jsonOptional: values[safe: i] as? [String:Any])
                        {
                            apiModels.append(apiModel)
                            
                            if let modelType = modelType //Store in DB if applicable
                            {
                                _ = modelType.insert(apiModel, into: NSStringFromClass(modelType).components(separatedBy: ".").last)
                            }
                        }
                    }
                    value = apiModels //Override default with our better parsed version
                }
            }
            else if let type = TypeHelper.type(from: property, ofObject: self),
                type.contains("APIModel") //Recursively handle models
            {
                let apiModelType: APIModel.Type = APIModel.children.filter{type == String(describing: $0)}[0]
                let apiModel = apiModelType.init(jsonOptional: json[T.getServerName(forClientName: property)] as? [String:Any])
                value = apiModel //Override default with our better parsed version
                
                let modelType = self.getModelType(fromAPIModelType: apiModelType)
                if let modelType = modelType //Store in DB if applicable
                {
                    _ = modelType.insert(apiModel, into: NSStringFromClass(modelType).components(separatedBy: ".").last)
                }
            }
            self.setValue(value, forKey: property)
        }
    }
}
