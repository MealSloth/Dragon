//
//  ModelNonRecursible.swift
//  Dragon
//
//  Created by Michael Fourre on 12/8/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol ModelNonRecursible: PrettyPrintable
{
    
}

extension ModelNonRecursible where Self: APIModel
{
    func initialize<T: FieldNameConverter>(_ json: [String:Any], skip: [String] = [], using: T.Type)
    {
        for property in self.getProperties()
        {
            if !skip.contains(property)
            {
                self.setValue(json[T.getServerName(forClientName: property)], forKey: property)
            }
        }
        Log.info("Finished initializing model with values: \(self)")
    }
}
