//
//  PersistentModelRecursible.swift
//  Dragon
//
//  Created by Michael Fourre on 12/10/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol PersistentModelRecursible: ModelRecursible, PrettyPrintable
{
    
}

extension PersistentModelRecursible
{
    func getModel<T: APIModel>(model: [String: Any]?, using: T.Type?, with property: String) -> T?
    {
        guard let dict = model else { return nil }
        var value = self.value(forKey: property)
        if let array = value as? [APIModel], let element = array.first
        {
            value = element
        }
        if let _ = value as? AlbumAPIModel { let a = AlbumAPIModel(json: dict); _ = Album.insert(a); return a as? T }
        if let _ = value as? BlobAPIModel { let a = BlobAPIModel(json: dict); _ = Blob.insert(a); return a as? T }
        if let _ = value as? ChefAPIModel { let a = ChefAPIModel(json: dict); _ = Chef.insert(a); return a as? T }
        if let _ = value as? ConsumerAPIModel { let a = ConsumerAPIModel(json: dict); _ = Consumer.insert(a); return a as? T }
        if let _ = value as? LocationAPIModel { let a = LocationAPIModel(json: dict); _ = Location.insert(a); return a as? T }
        if let _ = value as? OrderAPIModel { let a = OrderAPIModel(json: dict); _ = Order.insert(a); return a as? T }
        if let _ = value as? OrderSummaryAPIModel { let a = OrderSummaryAPIModel(json: dict); _ = OrderSummary.insert(a); return a as? T }
        if let _ = value as? OrderTimeAPIModel { let a = OrderTimeAPIModel(json: dict); _ = OrderTime.insert(a); return a as? T }
        if let _ = value as? PostAPIModel { let a = PostAPIModel(json: dict); _ = Post.insert(a); return a as? T }
        if let _ = value as? ReviewAPIModel { let a = ReviewAPIModel(json: dict); _ = Review.insert(a); return a as? T }
        if let _ = value as? UserAPIModel { let a = UserAPIModel(json: dict); _ = User.insert(a); return a as? T }
        if let _ = value as? UserLoginAPIModel { let a = UserLoginAPIModel(json: dict); _ = UserLogin.insert(a); return a as? T }
        return nil
    }
}
