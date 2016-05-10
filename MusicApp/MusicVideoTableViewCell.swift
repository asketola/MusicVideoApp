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
//    musicImage.image = UIImage(named: "image_not_available.gif")
    
    if video!.videoImageData != nil {
        print("Get data from array. . . . ")
        musicImage.image = UIImage(data: video!.videoImageData!)
    } else {
        GetVideoImage(video!, imageView: musicImage)
        print("Get images in background thread")
    }
    
    
    }
    
    func GetVideoImage(video: Videos, imageView: UIImageView) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            print("video imageurl: \(video.videoImageUrl)")
            
            let data = NSData(contentsOfURL: NSURL(string: video.videoImageUrl)!)
            
            var image : UIImage?
            if data != nil {
                video.videoImageData = data
                image = UIImage(data: data!)!
            }
            
            // move back to the main queue
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
            
        }
    }
}