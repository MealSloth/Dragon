//
//  Constraint.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

func constrain(_ attributing: NSLayoutAttribute?, of constraining: UIView?, to attributed: NSLayoutAttribute?, of constrained: UIView?, by constant: CGFloat?, multiplier: CGFloat? = nil) {
    guard let constraining = constraining else { return }
    let constraint = NSLayoutConstraint(
        item: constraining,
        attribute: attributing ?? .top,
        relatedBy: .equal,
        toItem: constrained,
        attribute: attributed ?? .top,
        multiplier: multiplier ?? 1.0,
        constant: constant ?? 0.0
    )
    let hierarchy = constrained ?? constraining
    hierarchy.addConstraint(constraint)
}

func constrain(_ attributes: [NSLayoutAttribute], of constraining: UIView?, to constrained: UIView?, by constant: CGFloat?) {
    for attribute in attributes {
        constrain(attribute, of: constraining, to: attribute, of: constrained, by: constant)
    }
}

func constrain(_ attributing: NSLayoutAttribute?, of constraining: UIView?, by constant: CGFloat?) {
    constrain(attributing, of: constraining, to: .notAnAttribute, of: nil, by: constant)
}

func constrain(_ attributes: [NSLayoutAttribute], of constraining: UIView?, by constant: CGFloat?) {
    for attribute in attributes {
        constrain(attribute, of: constraining, by: constant)
    }
}

func constrain(_ operation: ConstraintOperation) {
    switch operation {
        case .sides(let constraining, let constrained, let constant):
            constrain([.top, .leading, ], of: constraining, to: constrained, by: constant)
            constrain([.bottom, .trailing, ], of: constraining, to: constrained, by: 0.0 - (constant ?? 0.0))
            break
    }
}

enum ConstraintOperation {
    case sides(of: UIView?, to: UIView?, by: CGFloat?)
}
