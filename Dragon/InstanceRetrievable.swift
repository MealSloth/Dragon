//
//  InstanceRetrievable.swift
//  Dragon
//
//  Created by Michael Fourre on 11/9/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import UIKit

protocol InstanceRetrievable {
    
}

extension InstanceRetrievable where Self: AppDelegate {
    static var instance: Self? {
        return UIApplication.shared.delegate as? Self
    }
}

extension InstanceRetrievable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: type(of: self)).components(separatedBy: ".").first ?? ""
    }
    
    static func instance(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
    }
}
