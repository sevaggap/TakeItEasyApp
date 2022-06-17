//
//  NotesHelper.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import Foundation
import UIKit
import CoreData

class NotesHelper {
    
    static var notes = NotesHelper()
     
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    let userDefaults = UserDefaults.standard
    
    // get all the notes
    func getNotes() -> [UsersNotes]{
         
        var notes = [UsersNotes]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersNotes")
        
        do {
            notes = try context?.fetch(fetchRequest) as! [UsersNotes]
        } catch {
            print("can't fetch notes data")
        }
        
        return notes
        
    }
    
    func getNotesForUser() -> [UsersNotes]{
        
        var user = User()
        var notes =  [UsersNotes]()
        let userEmail = userDefaults.string(forKey: "lastUser")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email: %@", userEmail!)
        
        do{
            let users = try context?.fetch(fetchRequest)
            if users?.count != 0 {
                user = users?.first as! User
                notes =  user.notes!
                }
            } catch {
                print("could not find user")
            }
        
        return notes
        
    }
    
    // add a note to the database
    func addNote(title : String, body : String){
        
        let note = NSEntityDescription.insertNewObject(forEntityName: "UsersNotes", into: context!) as! UsersNotes
        note.noteId = Int64.random(in: 1...1000000)
        note.title = title
        note.body = body
        note.date = Date()
        
        do {
            try context?.save()
            print("note save")
        } catch {
            print("could not save note")
        }
        
    }
    
    func addNoteForUser(title : String, body : String){
        
        var user = User()
        let userEmail = userDefaults.string(forKey: "lastUser")
        
        let note = NSEntityDescription.insertNewObject(forEntityName: "UserNotes", into: context!) as! UsersNotes
        note.noteId = Int64.random(in: 1...1000000)
        note.title = title
        note.body = body
        note.date = Date()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "email: %@", userEmail!)
        
        do{
            let users = try context?.fetch(fetchRequest)
            if users?.count != 0 {
                user = users?.first as! User
                user.notes?.append(note)
                try context?.save()
                print("note saved to user")
                }
            } catch {
                print("could not find user")
            }
        
    }
    
    
    // update an existing note
    func updateNote(noteId : Int64, title : String, body : String){
        
        var note = UsersNotes()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersNotes")
        fetchRequest.predicate = NSPredicate(format: "noteId == %@", String(noteId))
        
        do {
            let updatedNote = try context?.fetch(fetchRequest)
            if updatedNote?.count != 0 {
                note = updatedNote?.first as! UsersNotes
                note.title = title
                note.body = body
                note.date = Date()
                try context?.save()
                print("note updated")
            }
        } catch {
            print("could not update note")
        }
    }
    
//    func updateNoteForUser(noteId : Int64, title : String, body: String){
//        
//        var user = User()
//        let userEmail = userDefaults.string(forKey: "lastUser")
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        fetchRequest.predicate = NSPredicate(format: "email: %@", userEmail!)
//        
//        do {
//            let users = try context?.fetch(fetchRequest)
//            if users?.count != 0 {
//                user = users?.first as! User
//            
//            }
//            print("user note updated")
//        } catch {
//            print("could not update user note")
//        }
//        
//    }
    
    // delete one note via noteId
    func deleteNote(noteId: Int64){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersNotes")
        fetchRequest.predicate = NSPredicate(format: "noteId == %@", String(noteId))
        
        do {
            let deletedNote = try context?.fetch(fetchRequest)
            if deletedNote?.count != 0 {
                context?.delete(deletedNote?.first as! UsersNotes)
                try context?.save()
                print("note has been deleted")
            } else {
                print("note not found")
            }
        }  catch {
            print("could not delete note")
        }
    }
    
    func favouriteNote(noteId : Int64) {
        
        var note = UsersNotes()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersNotes")
        fetchRequest.predicate = NSPredicate(format: "noteId == %@", String(noteId))
        
        do {
            let favouriteNote = try context?.fetch(fetchRequest)
            if favouriteNote?.count != 0 {
                note = favouriteNote?.first as! UsersNotes
                if(note.isFavourite){
                    note.isFavourite = false
                    try context?.save()
                    print("note favourited")
                } else {
                    note.isFavourite = true
                    try context?.save()
                    print("note unfavourited")
                }
            }
        } catch {
            print("could not favourite note")
        }
    }
    
}
