//
//  UpdateNotesViewController.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit

class UpdateNotesViewController: UIViewController {

    var titleData : String? = " "
    var bodyData : String? = " "
    var noteId : Int64 = 0
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.text = titleData
        noteBody.text = bodyData
    }
    
    @IBAction func updateNotePressed(_ sender: Any) {
        print("updating")
        NotesHelper.notes.updateNote(noteId: noteId, title: noteTitle.text!, body: noteBody.text!)
    }

}
