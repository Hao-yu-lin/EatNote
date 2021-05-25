//
//  EatNoteTableViewCell.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/23.
//

import UIKit

class EatNoteTableViewCell: UITableViewCell {
    
    
    // MARK: - Declare Label
    @IBOutlet var nameLabel: UILabel!{
        didSet{
            nameLabel.numberOfLines = 0
        }
    }
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!{
        didSet{
            typeLabel.layer.cornerRadius = 10.0
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!{
        didSet{
            thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.width/2
            thumbnailImageView.clipsToBounds = true
        }
    }
    @IBOutlet var checkImageView: UIImageView!
  
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
