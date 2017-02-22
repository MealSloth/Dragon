//
//  Message.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

struct Message: Messageable {
    enum MessageDuration: Double {
        case short = 5.0
        case medium = 8.0
        case long = 12.0
    }
    
    enum CannedMessage: String {
        case errorTryAgainLater = "There was an error. Please try again later."
    }
    
    var text: String?
    
    init(_ text: String?) {
        self.text = text
    }
    
    init(_ message: CannedMessage?) {
        self.text = message?.rawValue
    }
    
    func display(duration: MessageDuration? = nil) {
        Message.display(text: self.text, duration: duration?.rawValue ?? MessageDuration.short.rawValue)
    }
}
