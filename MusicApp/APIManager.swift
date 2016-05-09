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
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(result: (error!.localizedDescription))
                } else {
                    completion(result: "NSURLSession successful")
                    print(data)
                }
            }
        }
        task.resume()
        // stuff
        
    }
}
