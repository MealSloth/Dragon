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
    
    fileprivate static var container: UIView?
    fileprivate static var background: UIView?
    fileprivate static var label: UILabel?
    
    var container: UIView { return MessageableView.messageableContainer }
    var background: UIView { return MessageableView.messageableBackground }
    var label: UILabel { return MessageableView.messageableLabel }
    
    init() {
        _ = MessageableView.messageableContainer
    }
}

fileprivate protocol ViewMessageable {
    static var container: UIView? { get set }
    static var background: UIView? { get set }
    static var label: UILabel? { get set }
}

fileprivate extension ViewMessageable {
    fileprivate static var messageableContainer: UIView {
        guard let container = self.container else {
            let container = UIView()
            container.alpha = 0.0
            
            container.addSubview(self.messageableBackground)
            container.translatesAutoresizingMaskIntoConstraints = false
            self.container = container
            let top = UIApplication.shared.windows.first
            top?.addSubview(container)
            top?.bringSubview(toFront: container)
            self.constrainViews(in: top)
            return container
        }
        return container
    }
    
    fileprivate static var messageableBackground: UIView {
        guard let background = self.background else {
            let background = UIView()
            background.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
            background.layer.cornerRadius = 5
            background.clipsToBounds = true
            background.addSubview(self.messageableLabel)
            background.translatesAutoresizingMaskIntoConstraints = false
            self.background = background
            return background
        }
        return background
    }
    
    fileprivate static var messageableLabel: UILabel {
        guard let label = self.label else {
            let label = UILabel()
            label.font = label.font.withSize(13.0)
            label.backgroundColor = .clear
            label.numberOfLines = 0
            label.textColor = .white
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            self.label = label
            return label
        }
        return label
    }
    
    fileprivate static func constrainViews(in top: UIView?) {
        guard let top = top else { return }
        constrain(.width, of: self.container, to: .width, of: top, by: 0.0, multiplier: 0.8)
        constrain(.bottom, of: self.container, to: .bottom, of: top, by: -30.0)
        constrain(.centerX, of: self.container, to: .centerX, of: top, by: 0.0)
        constrain(.sides(of: self.background, to: self.container, by: 0.0))
        constrain(.sides(of: self.label, to: self.background, by: 8.0))
    }
}
