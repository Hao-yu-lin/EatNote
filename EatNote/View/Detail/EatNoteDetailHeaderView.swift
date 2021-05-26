//
//  EatNoteDetailHeaderView.swift
//  EatNote
//
//  Created by Haoyu Lin on 2021/5/24.
//

import UIKit

class EatNoteDetailHeaderView: UIView {
//
    @IBOutlet var checkImageView: UIImageView!
//    @IBOutlet var nameLabel: UILabel!{
//        didSet{
//            nameLabel.numberOfLines = 0
//        }
//    }
    @IBOutlet var typeLabel: UILabel!{
        didSet{
            typeLabel.layer.cornerRadius = 10.0
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var headerImageView: UIImageView!{
        didSet{
            headerImageView.layer.cornerRadius = headerImageView.bounds.width/2
            headerImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var ratingImageView: UIImageView!
}
