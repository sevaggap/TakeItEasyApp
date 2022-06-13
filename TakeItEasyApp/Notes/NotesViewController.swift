//
//  TableViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit
import Foundation

class NotesViewController: UIViewController {

    @IBOutlet weak var notesTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
        
    static var tableObj :  UITableView!
    
    static var notes = [UsersNotes]()
    var notesTitles = [String]()
    var searchedNotes = [String]()
    var searching  = false
         
    override func viewWillAppear(_ animated: Bool) {
        notesTitles.removeAll()
        NotesViewController.notes = NotesHelper.notes.getNotes()
        for note in NotesViewController.notes {
            notesTitles.append(note.title!)
        }
        print(notesTitles)
        notesTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotesViewController.notes = NotesHelper.notes.getNotes()
        NotesViewController.tableObj = notesTable
        for note in NotesViewController.notes {
            notesTitles.append(note.title!)
        }
        notesTable.reloadData()

    }

    @IBAction func newNotePressed(_ sender: Any) {
        
        let saveNoteScreen = storyboard?.instantiateViewController(withIdentifier: "saveNotes")
        navigationController?.pushViewController(saveNoteScreen!, animated: true)
        
    }
    
    func dateFormat(date : Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        let hourFormatter = DateFormatter()
        hourFormatter.timeZone = TimeZone(abbreviation: "EST")
        hourFormatter.dateFormat = "HH"
        
        let minuteFormatter = DateFormatter()
        minuteFormatter.timeZone = TimeZone(abbreviation: "EST")
        minuteFormatter.dateFormat = "mm"
        
        var hourString = hourFormatter.string(from: date)
        let hourInt = Int(hourString)
        let minuteString = minuteFormatter.string(from: date)
        
        if hourInt! > 12 {
             hourString = "\(String(hourInt!-12)):\(minuteString) PM"
        } else if hourInt! == 12 {
            hourString = "\(String(hourInt!)):\(minuteString) PM"
        } else if hourInt! == 0 {
            hourString = "\(String(hourInt! + 12)):\(minuteString) AM"
        } else {
            hourString = "\(String(hourInt!)):\(minuteString) AM"
        }
        
        return dateFormatter.string(from: date) + " " + hourString
        
    }
    
}

extension NotesViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searching = false
            print(searching)
            NotesViewController.notes = NotesHelper.notes.getNotes()
            notesTable.reloadData()
            } else {
                searchedNotes = notesTitles.filter({$0.prefix(searchText.count) == searchText})
                print(searchedNotes)
                searching = true
                notesTable.reloadData()
                print(searching)

        }
        
    }

}

extension NotesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
             return searchedNotes.count
        } else {
            return NotesViewController.notes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesTableViewCell

        print(NotesViewController.notes[indexPath.row].date)
        if NotesViewController.notes[indexPath.row].isFavourite {
            cell.noteFavouriteImage.image = UIImage(systemName: "heart.fill")
            cell.noteTitle.text =  NotesViewController.notes[indexPath.row].title
            cell.noteDate.text = dateFormat(date: NotesViewController.notes[indexPath.row].date!)
        } else if searching {
            cell.noteTitle.text = searchedNotes[indexPath.row]
            cell.noteFavouriteImage.image =  nil
            cell.noteDate.text = ""
        } else {
            cell.noteTitle.text =  NotesViewController.notes[indexPath.row].title
            cell.noteDate.text = dateFormat(date: NotesViewController.notes[indexPath.row].date!)
            cell.noteFavouriteImage.image = nil
        }
        
        return cell
    }
    
}

extension NotesViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row, NotesViewController.notes[indexPath.row].title,NotesViewController.notes[indexPath.row].body)
        
        let updateNoteScreen = storyboard?.instantiateViewController(withIdentifier: "updateNotes") as! UpdateNotesViewController
        
        print(searching)
        
        if searching {
            updateNoteScreen.titleData =  searchedNotes[indexPath.row]
        } else {
            print("in else")
            updateNoteScreen.titleData = NotesViewController.notes[indexPath.row].title
            updateNoteScreen.bodyData = NotesViewController.notes[indexPath.row].body
            updateNoteScreen.noteId = NotesViewController.notes[indexPath.row].noteId
            print("note id id",NotesViewController.notes[indexPath.row].noteId)
        }
    
        print("in did select")
        navigationController?.pushViewController(updateNoteScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { _ , IndexPath in
            
            NotesHelper.notes.deleteNote(noteId: NotesViewController.notes[indexPath.row].noteId)
            NotesViewController.notes = NotesHelper.notes.getNotes()
            self.notesTable.reloadData()

        })
        
        let note = NotesViewController.notes[indexPath.row]
        let favouriteActionTitle = note.isFavourite ? "Unfavourite" : "Favourite"
        
        let favouriteAction = UITableViewRowAction(style: .normal, title: favouriteActionTitle, handler: {_,_ in
            
            NotesHelper.notes.favouriteNote(noteId: NotesViewController.notes[indexPath.row].noteId)
            NotesViewController.notes = NotesHelper.notes.getNotes()
            self.notesTable.reloadData()
            
        })
        
        favouriteAction.backgroundColor = .orange
        
        return [deleteAction,favouriteAction]
    }
    
}

