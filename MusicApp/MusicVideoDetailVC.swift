//
//  MusicVideoDetailVC.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/10/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MusicVideoDetailVC: UIViewController {
    
    var videos:Videos!

    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "prefferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        title = videos.videoArtist

        vName.text = videos.videoName
        vPrice.text = videos.videoPrice
        vRights.text = videos.videoRights
        vGenre.text = videos.videoGenre
        
        if videos.videoImageData != nil {
            videoImage.image = UIImage(data: videos.videoImageData!)
        } else {
            videoImage.image = UIImage(named: "image_not_available.gif")
        }
    }
    
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        shareMedia()
    }
    
    // only be executed if touchID goes through/security
    func shareMedia() {
        
        print("We got here")
        
        let act1 = "Have you had the opportunity to see this Music Video?"
        let act2 = ("\(videos.videoName) by \(videos.videoArtist)")
        let act3 = "Watch it and tell me what you think?"
        let act4 = videos.videoLinkToiTunes
        let act5 = "(Shared with the Music Video App - Step it up!)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [act1, act2, act3, act4, act5], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityTypeMail {
                print("email selected")
            }
        }
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.videoUrl)!
        
        let player = AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    
    
    func prefferedFontChange() {
        vGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        vPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        vRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        vName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged:", object: nil)
    }

}
