//
//  MusicVideoDetailVC.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/10/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import UIKit

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
    
    func prefferedFontChange() {
        print("The preferred Font has Changed")
    }

}
