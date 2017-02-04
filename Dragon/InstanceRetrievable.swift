//
//  InstanceRetrievable.swift
//  Dragon
//
//  Created by Michael Fourre on 11/9/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

protocol InstanceRetrievable {
    
}

extension InstanceRetrievable where Self: AppDelegate {
    static func getInstance() -> Self? {
        return UIApplication.shared.delegate as? Self
    }
}
