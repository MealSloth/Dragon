//
//  BackgroundQueue.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

struct BackgroundQueue: Queueable {
    static let name = "com.mealsloth.backgroundqueue"
    static let sharedDispatch = DispatchQueue(label: "com.mealsloth.backgroundqueue", qos: .background, target: nil)
    
    static func sync(_ block: (() -> Void)?) {
        self.sharedDispatch.sync(execute: { () -> Void in
            Thread.current.name = self.name
            block?()
        })
    }
    
    static func async(_ block: (() -> Void)?) {
        self.sharedDispatch.async(execute: { () -> Void in
            Thread.current.name = self.name
            block?()
        })
    }
}
