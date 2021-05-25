//
//  EatNoteDetailPhoneCell.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/25.
//

import UIKit

class EatNoteDetailPhoneCell: UITableViewCell {

    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var shortTextLabel: UILabel!{
        didSet{
            shortTextLabel.numberOfLines = 0
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
