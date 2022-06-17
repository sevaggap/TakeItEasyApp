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
        
    @IBOutlet weak var navBar: UINavigationItem!
    
    static var tableObj :  UITableView!
    
    static var notes = [UsersNotes]()
    var searchedNotes : [UsersNotes] = []
    var searching  = false
         
    // when the view will appear, the notes are retrived from core data
    override func viewWillAppear(_ animated: Bool) {
        searchedNotes.removeAll()
        NotesViewController.notes = NotesHelper.notes.getNotes()
        searchedNotes = NotesViewController.notes
        print(searchedNotes)
        notesTable.reloadData()
    }
    
    // when the view will load, the notes are retrived from core data
    override func viewDidLoad() {
        super.viewDidLoad()
        NotesViewController.notes = NotesHelper.notes.getNotes()
        NotesViewController.tableObj = notesTable
        notesTable.reloadData()
        navBar.title = "Sevag"

    }

    // when the new note button is pressed, a screen will open where the user can enter new notes
    @IBAction func newNotePressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Notes", bundle: nil)
        let saveNoteScreen = storyboard.instantiateViewController(withIdentifier: "saveNotes")
        navigationController?.pushViewController(saveNoteScreen, animated: true)
        
    }
    
    // this function handles the formatting of the date for notes, using logic to display AM or PM depening on the hour value
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

// this function searchs through the note titles based on what the user types in the serach bar
extension NotesViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedNotes.removeAll()
        print("in search")
        if searchText == "" {
            searching = false
            NotesViewController.notes = NotesHelper.notes.getNotes()
            notesTable.reloadData()
            } else {
                for Note in NotesViewController.notes{
                    if Note.title!.lowercased().contains(searchText.lowercased()) {
                        searchedNotes.append(Note)
                    }
                searching = true
            }
            print(searchedNotes)
            notesTable.reloadData()
        }
        
    }

}

// specifies the number of rows for the table
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

        // checks if the note is favourited or if the user is searching and updates what is being displayed in the table
        if NotesViewController.notes[indexPath.row].isFavourite {
            cell.noteFavouriteImage.image = UIImage(systemName: "heart.fill")
            cell.noteTitle.text =  NotesViewController.notes[indexPath.row].title
            cell.noteDate.text = dateFormat(date: NotesViewController.notes[indexPath.row].date!)
        } else if searching {
            if searchedNotes[indexPath.row].isFavourite {
                cell.noteFavouriteImage.image = UIImage(systemName: "heart.fill")
            } else {
            cell.noteTitle.text = searchedNotes[indexPath.row].title
            cell.noteFavouriteImage.image =  nil
            cell.noteDate.text = dateFormat(date: searchedNotes[indexPath.row].date!)
                print("in else searching")
            }
        } else {
            cell.noteTitle.text =  NotesViewController.notes[indexPath.row].title
            cell.noteDate.text = dateFormat(date: NotesViewController.notes[indexPath.row].date!)
            cell.noteFavouriteImage.image = nil
        }
        
        cell.backgroundColor = UIColor(named: "takeItEasyPurple")
        cell.layer.cornerRadius = 20
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowOffset  = CGSize(width: 3, height: 3)
        cell.layer.shadowColor = CGColor(red: 200, green: 200, blue: 200, alpha: 1.0)
        return cell
    }
    
}

// specifies what happens when a row of the table is selected
extension NotesViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row, NotesViewController.notes[indexPath.row].title,NotesViewController.notes[indexPath.row].body)
        
        let storyboard = UIStoryboard(name: "Notes", bundle: nil)
        let updateNoteScreen = storyboard.instantiateViewController(withIdentifier: "updateNotes") as! UpdateNotesViewController
        
        print(searching)
        
        if searching {
            updateNoteScreen.titleData = searchedNotes[indexPath.row].title
            updateNoteScreen.bodyData = searchedNotes[indexPath.row].body
            updateNoteScreen.noteId = searchedNotes[indexPath.row].noteId
            print("note id",searchedNotes[indexPath.row].noteId)
        } else {
            updateNoteScreen.titleData = NotesViewController.notes[indexPath.row].title
            updateNoteScreen.bodyData = NotesViewController.notes[indexPath.row].body
            updateNoteScreen.noteId = NotesViewController.notes[indexPath.row].noteId
            print("note id id",NotesViewController.notes[indexPath.row].noteId)
        }
    
        navigationController?.pushViewController(updateNoteScreen, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { _ , IndexPath in
            
            if self.searching {
                NotesHelper.notes.deleteNote(noteId: self.searchedNotes[indexPath.row].noteId)
            } else {
                NotesHelper.notes.deleteNote(noteId: NotesViewController.notes[indexPath.row].noteId)
            }
            
            NotesViewController.notes = NotesHelper.notes.getNotes()
            self.notesTable.reloadData()

        })
        
        let note = NotesViewController.notes[indexPath.row]
        let favouriteActionTitle = note.isFavourite ? "Unfavourite" : "Favourite"
        
        let favouriteAction = UITableViewRowAction(style: .normal, title: favouriteActionTitle, handler: {_,_ in
            
            if self.searching {
                NotesHelper.notes.favouriteNote(noteId: self.searchedNotes[indexPath.row].noteId)
            } else {
                NotesHelper.notes.favouriteNote(noteId: NotesViewController.notes[indexPath.row].noteId)
            }
            
            NotesViewController.notes = NotesHelper.notes.getNotes()
            self.notesTable.reloadData()
            
        })
        
        favouriteAction.backgroundColor = .orange
        
        return [deleteAction,favouriteAction]
    }
    
}

