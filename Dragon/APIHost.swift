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
    case CHIMERA
    case HYDRA
    
    func url() -> String
    {
        switch (self)
        {
            case .CHIMERA: return "http://api.mealsloth.com/"
            case .HYDRA: return "http://blob.mealsloth.com/"
        }
    }
}
