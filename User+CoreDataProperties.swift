//
//  User+CoreDataProperties.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-08.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?

}

extension User : Identifiable {

}
