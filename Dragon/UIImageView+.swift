//
//  UIImageView+.swift
//  Dragon
//
//  Created by Michael Fourre on 7/28/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeCircular() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func display(image: UIImage?, animated: Bool = true, activityIndicator indicator: UIActivityIndicatorView? = nil) {
        guard let image = image else { return }
        MainQueue.async({ () -> Void in
            indicator?.enable()
            self.isHidden = true
            BackgroundQueue.async({ () -> Void in
                let changes = { () -> Void in
                    self.isHidden = false
                    self.image = image
                    indicator?.disable()
                }
                MainQueue.async({ () -> Void in
                    animated ? UIView.animate(withDuration: 0.3, animations: changes) : changes()
                })
            })
        })
    }
    
    func display(blob: Blob?, animated: Bool = true, activityIndicator indicator: UIActivityIndicatorView? = nil) {
        guard let blob = blob else { return }
        MainQueue.async({ () -> Void in
            indicator?.enable()
            self.isHidden = true
            BackgroundQueue.async({ () -> Void in
                self.display(image: blob.image, animated: animated, activityIndicator: indicator)
            })
        })
    }
}
