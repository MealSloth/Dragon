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
        if let _ = value as? AlbumAPIModel { let a = AlbumAPIModel(json: dict); let _ = Album.insertOrUpdate(a); return a as? T }
        if let _ = value as? BlobAPIModel { let a = BlobAPIModel(json: dict); let _ = Blob.insertOrUpdate(a); return a as? T }
        if let _ = value as? ChefAPIModel { let a = ChefAPIModel(json: dict); let _ = Chef.insertOrUpdate(a); return a as? T }
        if let _ = value as? ConsumerAPIModel { let a = ConsumerAPIModel(json: dict); let _ = Consumer.insertOrUpdate(a); return a as? T }
        if let _ = value as? LocationAPIModel { let a = LocationAPIModel(json: dict); let _ = Location.insertOrUpdate(a); return a as? T }
        if let _ = value as? OrderAPIModel { let a = OrderAPIModel(json: dict); let _ = Order.insertOrUpdate(a); return a as? T }
        if let _ = value as? OrderSummaryAPIModel { let a = OrderSummaryAPIModel(json: dict); let _ = OrderSummary.insertOrUpdate(a); return a as? T }
        if let _ = value as? OrderTimeAPIModel { let a = OrderTimeAPIModel(json: dict); let _ = OrderTime.insertOrUpdate(a); return a as? T }
        if let _ = value as? PostAPIModel { let a = PostAPIModel(json: dict); let _ = Post.insertOrUpdate(a); return a as? T }
        if let _ = value as? ReviewAPIModel { let a = ReviewAPIModel(json: dict); let _ = Review.insertOrUpdate(a); return a as? T }
        if let _ = value as? UserAPIModel { let a = UserAPIModel(json: dict); let _ = User.insertOrUpdate(a); return a as? T }
        if let _ = value as? UserLoginAPIModel { let a = UserLoginAPIModel(json: dict); let _ = UserLogin.insertOrUpdate(a); return a as? T }
        return nil
    }
}
