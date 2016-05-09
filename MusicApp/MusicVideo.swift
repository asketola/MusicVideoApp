//
//  MusicVideo.swift
//  MusicApp
//
//  Created by Annemarie Ketola on 5/9/16.
//  Copyright © 2016 Annemarie Ketola. All rights reserved.
//

import Foundation

class Videos {
    
    // Data encapsulation
    
    private var _videoName:String
    private var _videoImageUrl:String
    private var _videoUrl:String
    
    // make getters since the variables are private
    
    var videoName: String {
        return _videoName
    }
    
    var videoImageUrl: String {
        return _videoName
    }
    
    var videoUrl: String {
        return _videoUrl
    }
    
    
    init(data: JSONDictionary) {
        
        // video name
        if let name = data["im:name"] as? JSONDictionary, videoName = name["label"] as? String {
            self._videoName = videoName
        } else {
            _videoName = ""  // because we might not get this data back
        }
        
        // video Image
        if let img = data["im:image"] as? JSONArray, image = img[2] as? JSONDictionary, image2 = image["label"] as? String {
            _videoImageUrl = image2.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _videoImageUrl = ""
        }
        
        // video url
        if let video = data["link"] as? JSONArray, vUrl = video[1] as? JSONDictionary, videoHref = vUrl["attributes"] as? JSONDictionary, videoUrl = videoHref["href"] as? String {
            self._videoUrl = videoUrl
        } else {
            _videoUrl = ""
        }
    }
    
    
    
    
    
    
    
    
} // closes Video
