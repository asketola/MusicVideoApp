//
//  APIManager.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/9/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: (result:String) -> Void) {
        
        // no persistant cashing
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
           
                if error != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                    completion(result: (error!.localizedDescription))
                    }
                } else {
                    
                    do {
                        //* .AllowFragmentation - top level object is not array or Dictionary
                        // NSJSONSerialization requires Do/Try/Catch converts from NSData to JSON Object and casts it into a dictionary Swift 2.0 change
                        
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary {
                            print(json)
                            
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    completion(result: "JSONSerialization Successful")
                                }
                            }
                        }
                    } catch {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(result: "error in NSJSONSerialization")
                            }
                        } // End of JSONSerialization
            }
        } // closes task
        task.resume() // this has to be outside the task {}
  } // closes loadData function
} // closes APIManager class
