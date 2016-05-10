//
//  MusicVideoTableViewCell.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/10/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    
    var video : Videos? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    
func updateCell() {
    
    musicTitle.text = video?.videoName
    rank.text = ("Ranking \(video!.videoRank)")
    musicImage.image = UIImage(named: "image_not_available.gif")
    
    }
}