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
    
    func addNote(title : String, body : String){
        
        let note = NSEntityDescription.insertNewObject(forEntityName: "UsersNotes", into: context!) as! UsersNotes
        note.noteId = Int64.random(in: 1...1000000)
        note.title = title
        note.body = body
        
        do {
            try context?.save()
            print("note save")
        } catch {
            print("could not save note")
        }
        
    }
     
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
                try context?.save()
                print("note updated")
            }
        } catch {
            print("could not update note")
        }
    }
    
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
    
}
