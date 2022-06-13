//
//  NotesTableViewCell.swift
//  TakeItEasyApp
//
//  Created by Sevag Gaprielian on 2022-06-08.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteFavouriteImage: UIImageView!
    @IBOutlet weak var noteDate: UILabel!
    
    var noteId : Int64  = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    @IBAction func deleteButtonPressed(_ sender: Any) {
//        NotesHelper.notes.deleteNote(noteId: noteId)
//        NotesViewController.notes = NotesHelper.notes.getNotes()
//        NotesViewController.tableObj.reloadData()
//    }
    
}
