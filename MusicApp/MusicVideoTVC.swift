//
//  MusicVideoTVC.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/10/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {
    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "prefferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
    }
    
    func preferredFontChange() {
        print("The preffered font has changed")
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
        
        self.tableView.reloadData()
        
        //        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        //
        //        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
        //            // do something
        //        }
        //        alert.addAction(okAction)
        //        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func reachabilityStatusChanged() {
//        switch reachabilityStatus {
//        case NOACCESS : view.backgroundColor = UIColor.redColor()
//    //    displayLabel.text = "No internet"
//        case WIFI : view.backgroundColor = UIColor.greenColor()
//    //    displayLabel.text = "Reachable with WIFI"
//        case WWAN : view.backgroundColor = UIColor.yellowColor()
//     //   displayLabel.text = "Reachable with Cellular"
//        default:return
//        }
        
        switch reachabilityStatus {
        case NOACCESS:
//            view.backgroundColor = UIColor.redColor()
            // move back to main queue
            dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "No internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: { (UIAlertAction) -> Void in
                print("Cancel")
            })
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { (UIAlertAction) -> Void in
                print("Delete")
            })
            
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: { (UIAlertAction) -> Void in
                print("Ok")
            })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            }
            
        default:
//            view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("Do not refresh API)")
            } else {
                runAPI()
            }
            
            
            
        }
    }
    
    func runAPI() {
    // Call API
    let api = APIManager()
    api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetailIdentifier"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell
        
        cell.video = videos[indexPath.row]
//        cell.textLabel?.text = ("\(indexPath.row + 1)")
//        cell.detailTextLabel?.text = video.videoName

        return cell
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged:", object: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == storyboard.segueIdentifier{
            if let indexPath = tableView.indexPathForSelectedRow {
                let video = videos[indexPath.row]
                let destinationVC = segue.destinationViewController as! MusicVideoDetailVC
                destinationVC.videos = video
            }
        }
    }


}
