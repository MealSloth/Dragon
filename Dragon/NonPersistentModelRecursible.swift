//
//  NonPersistentModelRecursible.swift
//  Dragon
//
//  Created by Michael Fourre on 12/10/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol NonPersistentModelRecursible: ModelRecursible, PrettyPrintable
{
    
}

extension NonPersistentModelRecursible
{
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
