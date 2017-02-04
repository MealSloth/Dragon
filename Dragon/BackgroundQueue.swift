//
//  BackgroundQueue.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

struct BackgroundQueue: Queueable {
    static let shared = DispatchQueue(label: "com.mealsloth.backgroundqueue", qos: .background, target: nil)
    
    static func sync(_ block: (() -> Void)?) {
        self.shared.sync(execute: block ?? {})
    }
    
    static func async(_ block: (() -> Void)?) {
        self.shared.async(execute: block ?? {})
    }
}
