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
        for property in self.getProperties() where !skip.contains(property)
        {
            var value: Any? = json[T.getServerName(forClientName: property)] //The default value is most common
            let type = String(describing: type(of: Mirror(reflecting: self).children.filter{$0.label! == property}[0].value))
            if let values = value as? [Any] //Handle arrays
            {
                if let optionalType = type.components(separatedBy: "<").last?.components(separatedBy: ">").first,
                    optionalType.contains("APIModel") //Recursively handle arrays of models
                {
                    let modelType: APIModel.Type = APIModel.children.filter{optionalType == String(describing: $0)}[0]
                    var models: [APIModel] = []
                    for i in 0..<values.count
                    {
                        if let model = modelType.init(jsonOptional: values[safe: i] as? [String: Any])
                        {
                            models.append(model)
                        }
                    }
                    value = models
                }
            }
            else if let optionalType = type.components(separatedBy: "<").last?.components(separatedBy: ">").first,
                optionalType.contains("APIModel") //Recursively handle models
            {
                for child in APIModel.children where optionalType == String(describing: child)
                {
                    value = child.init(jsonOptional: json[T.getServerName(forClientName: property)] as? [String: Any])
                }
            }
            self.setValue(value, forKey: property)
        }
        Log.info("Finished initializing APIModel with values: \(self)")
    }
}
