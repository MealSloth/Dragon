//
//  MainQueue.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

struct MainQueue: Queueable
{
    static let shared = OperationQueue.main
    
    static func sync(_ block: (() -> Void)?)
    {
        self.shared.addOperation(block ?? {})
    }
}
