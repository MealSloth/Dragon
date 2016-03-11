//
//  User+CoreDataProperties.swift
//  Dragon
//
//  Created by Hongyi on 16/2/12.
//  Copyright © 2016年 MealSloth. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var user_login_id: String?
    @NSManaged var consumer_id: String?
    @NSManaged var chef_id: String?
    @NSManaged var location_id: String?
    @NSManaged var billing_id: String?
    @NSManaged var profile_photo_id: String?
    @NSManaged var email: String?
    @NSManaged var first_name: String?
    @NSManaged var last_name: String?
    @NSManaged var phone_number: String?
    @NSManaged var date_of_birth: NSTimeInterval
    @NSManaged var gender: String?
    @NSManaged var id: String?

}
