//
//  UsersNotes+CoreDataProperties.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//
//

import Foundation
import CoreData


extension UsersNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersNotes> {
        return NSFetchRequest<UsersNotes>(entityName: "UsersNotes")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var noteId: Int64

}

extension UsersNotes : Identifiable {

}
