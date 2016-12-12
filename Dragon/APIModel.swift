//
//  APIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class APIModel: NSObject, PersistentModelRecursible, PrettyPrintable, ChildrenIdentifiable
{
    override var description: String {
        return self.getPropertiesString(self)
    }
    
    static var children: [AnyClass] = {
        return APIModel.getChildren()
    }()
    
    override init()
    {
        super.init()
    }
    
    init(json: [String: Any])
    {
        super.init()
        self.initialize(json)
    }
    
    init?(jsonOptional: [String: Any]?)
    {
        guard let json = jsonOptional else { return nil }
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
        //initialize(_:skip:using:) is a member of the ModelRecursible and ModelNonRecursible protocols
        //Depending on the complexity of your APIModel objects, it could be best to use one or the other
        self.initialize(json, skip: skip, using: FieldNameHelper.self)
    }
}
