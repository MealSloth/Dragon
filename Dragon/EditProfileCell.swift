//
//  EditProfileCell.swift
//  Dragon
//
//  Created by Michael Fourre on 1/10/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

protocol EditProfileCell: InstanceRetrievable {
    static var type: EditProfileCellType { get }
    var user: User? { get set }
    
    func initialize()
}

extension EditProfileCell where Self: UITableViewCell {
    static var cellIdentifier: String {
        return self.type.rawValue
    }
    
    static func instance(from tableView: UITableView, at indexPath: IndexPath, for user: User?) -> UITableViewCell {
        let cell = self.instance(from: tableView, at: indexPath)
        var profileCell = cell as? Self
        profileCell?.user = user
        profileCell?.initialize()
        return profileCell ?? cell
    }
}
