//
//  RefreshControllable.swift
//  Dragon
//
//  Created by Michael Fourre on 2/20/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

@objc protocol RefreshControllable {
    var refreshControl: UIRefreshControl? { get set }
    
    @objc func refresh()
}

extension RefreshControllable {
    func addRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    func endRefreshing() {
        MainQueue.sync({ () -> Void in
            self.refreshControl?.endRefreshing()
        })
    }
}
