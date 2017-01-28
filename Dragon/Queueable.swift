//
//  Queueable.swift
//  Dragon
//
//  Created by Michael Fourre on 1/28/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import Foundation

protocol Queueable
{
    static func sync(_ block: (() -> Void)?)
}
