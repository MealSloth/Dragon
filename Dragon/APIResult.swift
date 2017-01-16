//
//  APIResult.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

protocol APIResult
{
    var description: String? { get }
    
    init(result: [String:Any])
}

extension APIResult
{
    var description: String? {
        get { return String(describing: type(of: self)) }
    }
}
