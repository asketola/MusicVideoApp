//
//  ViewController.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/9/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(videos: [Videos]){
        
        print(reachabilityStatus)
        
        // makes variable global
        self.videos = videos
        
        for item in videos {
            print("name = \(item.videoName)")
        }
        
        // oldish way
//        for i in 0..<videos.count {
//            let video = videos[i]
//            print("\(i) name = \(video.videoName)")
//        }
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.videoName)")
        }
        
//        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
//        
//        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
//            // do something
//        }
//        alert.addAction(okAction)
//        self.presentViewController(alert, animated: true, completion: nil)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

