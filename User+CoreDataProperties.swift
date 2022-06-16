//
//  User+CoreDataProperties.swift
//  TakeItEasyApp
//
//  Created by user on 2022-06-15.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var readData: String?
    @NSManaged public var notes: [UsersNotes]?

}

// MARK: Generated accessors for notes
extension User {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: UsersNotes)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: UsersNotes)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

extension User : Identifiable {

}
