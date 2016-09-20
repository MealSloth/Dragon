//
//  APIHost.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

enum APIHost: AbstractEnum
{
    case chimera
    case hydra
    
    func url() -> String
    {
        switch (self)
        {
            case .chimera: return "http://api.mealsloth.com/"
            case .hydra: return "http://blob.mealsloth.com/"
        }
    }
}
