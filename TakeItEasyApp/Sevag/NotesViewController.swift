//
//  TableViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var notesTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
        
    static var tableObj :  UITableView!
    
    static var notes = [UsersNotes]()
    var notesTitles = [String]()
    var searchedNotes = [String]()
    var searching  = false
     
    // test push
    
    override func viewWillAppear(_ animated: Bool) {
        notesTitles.removeAll()
        NotesViewController.notes = NotesHelper.notes.getNotes()
        for note in NotesViewController.notes {
            notesTitles.append(note.title!)
        }
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
                searching = true
                notesTable.reloadData()
                print(searching)

        }
        
    }
   
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        NotesViewController.notes.removeAll()
//        NotesViewController.notes = NotesHelper.notes.getNotes()
//        notesTable.reloadData()
//    }
    
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
        
        if searching {
            cell.noteTitle.text = searchedNotes[indexPath.row]
        } else {
            cell.noteTitle.text =  NotesViewController.notes[indexPath.row].title
        }

//        cell.noteId = NotesViewController.notes[indexPath.row].noteId
        
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
        
        let favouriteAction = UITableViewRowAction(style: .normal, title: "Favourite", handler: {_,_ in
            print("favourite")
            
        })
        
        favouriteAction.backgroundColor = .orange
        
        return [deleteAction,favouriteAction]
    }
    
}
//
//let alertUI = UIAlertController(title: "Registration Successful", message: "You can proceed with login", preferredStyle: .actionSheet)
//            let okayAction = UIAlertAction(title: "Okay", style: .default){
//                (action) in
//                self.dismiss(animated: true, completion: {
//                    self.dismiss(animated: true)
//                })
//
//            }
