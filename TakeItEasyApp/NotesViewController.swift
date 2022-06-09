//
//  TableViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit

class NotesViewController: UIViewController {

    @IBOutlet weak var notesTable: UITableView!
    
    static var tableObj :  UITableView!
    
    static var notes = [UsersNotes]()
     
    override func viewWillAppear(_ animated: Bool) {
        NotesViewController.notes = NotesHelper.notes.getNotes()
        notesTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotesViewController.notes = NotesHelper.notes.getNotes()
        NotesViewController.tableObj = notesTable
    }

    @IBAction func newNotePressed(_ sender: Any) {
        
        let saveNoteScreen = storyboard?.instantiateViewController(withIdentifier: "saveNotes")
        navigationController?.pushViewController(saveNoteScreen!, animated: true)
        
    }
}

extension NotesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NotesViewController.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesTableViewCell
        
        cell.noteTitle.text =  NotesViewController.notes[indexPath.row].title
        cell.noteId = NotesViewController.notes[indexPath.row].noteId
        
        return cell
    }

    
}

extension NotesViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("hi")
        print(indexPath.row, NotesViewController.notes[indexPath.row].title,NotesViewController.notes[indexPath.row].body)
        
        let updateNoteScreen = storyboard?.instantiateViewController(withIdentifier: "updateNotes") as! UpdateNotesViewController
        
        updateNoteScreen.titleData = NotesViewController.notes[indexPath.row].title
        updateNoteScreen.bodyData = NotesViewController.notes[indexPath.row].body
        updateNoteScreen.noteId = NotesViewController.notes[indexPath.row].noteId
        
        navigationController?.pushViewController(updateNoteScreen, animated: true)
    }
    
}
