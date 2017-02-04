//
//  MainQueue.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

struct MainQueue: Queueable {
    static let sharedOperation = OperationQueue.main
    static let sharedDispatch = DispatchQueue.main
    
    static func sync(_ block: (() -> Void)?) {
        self.sharedOperation.addOperation(block ?? {})
    }
    
    static func async(_ block: (() -> Void)?) {
        self.sharedDispatch.async(execute: block ?? {})
    }
}
