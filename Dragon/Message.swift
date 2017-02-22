//
//  Message.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

struct Message: Messageable {
    var text: String?
    
    init(_ text: String?) {
        self.text = text
    }
    
    func display() {
        Message.display(text: self.text)
    }
}
