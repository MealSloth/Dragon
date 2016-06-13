//
//  APIHost.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import Foundation

class APIHost
{
    enum APIHostEnum
    {
        case CHIMERA
        case HYDRA
    }
    
    class func URL(service: APIHostEnum) -> String
    {
        switch (service)
        {
            case APIHostEnum.CHIMERA:
                return "http://api.mealsloth.com/"
            case APIHostEnum.HYDRA:
                return "http://blob.mealsloth.com/"
        }
    }
}