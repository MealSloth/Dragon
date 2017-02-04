//
//  ChefDataTest.swift
//  Dragon
//
//  Created by Michael Fourre on 12/20/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

@testable import Dragon

class ChefDataTest: DragonTest {
    func testTest() {
        if let chefs = Chef.all(), let count = Chef.all()?.count {
            Log.debug("# chefs: \(count)")
            for chef in chefs {
                Log.debug("\(chef)")
            }
        }
    }
}
