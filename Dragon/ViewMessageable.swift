//
//  ViewMessageable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/22/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

protocol ViewMessageable {
    static var container: UIView? { get set }
    static var background: UIView? { get set }
    static var label: UILabel? { get set }
}

extension ViewMessageable {
    var visible: Bool {
        get {
            return Self.messageableContainer.visible
        }
        set {
            Self.messageableContainer.visible = newValue
        }
    }
    
    func initialize() {
        _ = Self.messageableContainer
    }
}

extension ViewMessageable {
    static var messageableContainer: UIView {
        guard let container = self.container else {
            let container = UIView()
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
    
    static var messageableBackground: UIView {
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
    
    static var messageableLabel: UILabel {
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
        constrain(.width, of: self.background, .lessThanOrEqual, to: .width, of: self.container, by: 0.0)
        constrain(.centerX, of: self.background, to: .centerX, of: self.container, by: 0.0)
        constrain(.xSides(of: self.background, to: self.container, by: 0.0))
        constrain(.sides(of: self.label, to: self.background, by: 8.0))
    }
}
