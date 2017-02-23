//
//  MessageableView.swift
//  Dragon
//
//  Created by Michael Fourre on 2/22/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

struct MessageableView: ViewMessageable {
    static var shared = MessageableView()
    
    static var container: UIView?
    static var background: UIView?
    static var label: UILabel?
    
    var container: UIView { return MessageableView.messageableContainer }
    var background: UIView { return MessageableView.messageableBackground }
    var label: UILabel { return MessageableView.messageableLabel }
    
    init() {
        self.initialize()
        self.visible = false
    }
}
