//
//  QuizTableViewCell.swift
//  TakeItEasyApp
//
//  Created by Xavier on 6/17/22.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var labelAnswerOptions: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
