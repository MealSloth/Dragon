//
//  ClassValidatable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/4/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

protocol ClassValidatable {
    
}

extension ClassValidatable where Self: AnyObject {
    static func validClass(_ name: String?, in module: String?) -> Self.Type? {
        guard let className = name else { return nil }
        let classType: AnyClass? = NSClassFromString(className)
        return self.validClass(className, classType, in: module)
    }
    
    static func validClass(_ type: AnyClass?, in module: String?) -> Self.Type? {
        guard let classType = type else { return nil }
        let className = NSStringFromClass(classType)
        return self.validClass(className, classType, in: module)
    }
    
    static func validClass(_ name: String?, _ type: AnyClass?, in module: String?) -> Self.Type? {
        guard let classType = type else { return nil }
        guard let className = name else  { return nil }
        guard let moduleName = module else { return nil }
        guard className.contains(moduleName) else { return nil }
        guard className != NSStringFromClass(self) else { return nil }
        return classType as? Self.Type
    }
}
