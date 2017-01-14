//
//  EditProfileCell.swift
//  Dragon
//
//  Created by Michael Fourre on 1/10/17.
//  Copyright © 2017 MealSloth. All rights reserved.
//

import UIKit

class EditProfileCell: UITableViewCell
{
    var user: User?
    
    enum EditProfileCellType: String
    {
        case photo = "Photo"
        case basic = "Basic"
        case birthday = "Birthday"
        case gender = "Gender"
    }
    
    class func getInstance(from tableView: UITableView, at indexPath: IndexPath, ofType type: EditProfileCellType, for user: User?) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditProfile\(type.rawValue)Cell", for: indexPath)
        guard let editProfileCell = cell as? EditProfileCell else { return cell }
        editProfileCell.user = user
        return editProfileCell
    }
}
