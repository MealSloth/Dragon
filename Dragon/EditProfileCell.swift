//
//  EditProfileCell.swift
//  Dragon
//
//  Created by Michael Fourre on 1/10/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

protocol EditProfileCell
{
    static var type: EditProfileCellType { get }
    var user: User? { get set }
    
    func initialize()
}

extension EditProfileCell where Self: UITableViewCell
{
    static func getInstance(from tableView: UITableView, at indexPath: IndexPath, for user: User?) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfile\(Self.type.rawValue)Cell", for: indexPath)
        guard let profileCell = cell as? Self else { return cell }
        var editProfileCell = profileCell
        editProfileCell.user = user
        editProfileCell.initialize()
        return editProfileCell
    }
}
