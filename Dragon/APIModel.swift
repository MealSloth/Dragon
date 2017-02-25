//
//  APIModel.swift
//  Dragon
//
//  Created by Michael Fourre on 5/3/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class APIModel: NSObject, PersistentModelRecursible, PrettyPrintable, PropertiesEquatable, ChildrenIdentifiable {
    override var description: String {
        return self.getPropertiesString()
    }
    
    static var children: [APIModel.Type] = {
        return APIModel.getChildren()
    }()
    
    override init() {
        super.init()
    }
    
    required init(json: [String:Any]) {
        super.init()
        self.initialize(json)
    }
    
    required init?(jsonOptional: [String:Any]?) {
        guard let json = jsonOptional else { return nil }
        super.init()
        self.initialize(json)
    }
    
    //MARK: KVC Overrides
    override func value(forKey key: String) -> Any? {
        return self.value(for: key)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        self.set(value, for: key)
    }
    
    func value(for key: String) -> Any? {
        return super.value(forKey: key)
    }
    
    func set(_ value: Any?, for key: String) {
        super.setValue(value, forKey: key)
    }
    
    //This should be overridden by a subclass if one wishes to use a converter other than FieldNameHelper
    //Optionally, each individual model can manually initialize itself if the server's naming conventions
    //are not consistent enough to use a generic converter
    func initialize(_ json: [String:Any], skip: [String] = []) {
        //initialize(_:skip:using:) is a member of the ModelRecursible and ModelNonRecursible protocols
        //Depending on the complexity of your APIModel objects, it could be best to use one or the other
        self.initialize(json, skip: skip, using: FieldNameHelper.self)
        Log.info("Finished initializing APIModel with values: \(self)")
    }
    
    //MARK: Comparison operators
    static func ==(lhs: APIModel, rhs: APIModel) -> Bool {
        return equal(lhs, rhs)
    }
    
    static func !=(lhs: APIModel, rhs: APIModel) -> Bool {
        return !equal(lhs, rhs)
    }
}
