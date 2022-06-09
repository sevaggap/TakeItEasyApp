//
//  AddNotesViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit

class AddNotesViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveNotePressed(_ sender: Any) {
        NotesHelper.notes.addNote(title: noteTitle.text!, body: noteBody.text!)
    }
    

}
