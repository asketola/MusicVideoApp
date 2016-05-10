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
    
    var videoRank = 0
    
    private var _videoName:String
    private var _videoImageUrl:String
    private var _videoUrl:String
    private var _videoRights:String
    private var _videoPrice:String
    private var _videoArtist:String
    private var _videoImid:String
    private var _videoGenre:String
    private var _videoLinkToiTunes:String
    private var _videoReleaseDate:String
    
    // This gets created from the UI
    var videoImageData:NSData?
    
    // make getters since the property variables are private
    
    var videoName: String {
        return _videoName
    }
    
    var videoImageUrl: String {
        return _videoName
    }
    
    var videoUrl: String {
        return _videoUrl
    }
    
    var videoRights: String {
        return _videoRights
    }
    
    var videoPrice: String {
        return _videoPrice
    }
    
    var videoArtist: String {
        return _videoArtist
    }
    
    var videoImid: String {
        return _videoImid
    }
    
    var videoGenre: String {
        return _videoGenre
    }
    
    var videoLinkToiTunes: String {
        return _videoLinkToiTunes
    }
    
    var videoReleaseDate: String {
        return _videoReleaseDate
    }
    
    // Our custom initializer
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
        
        // video rights
        if let rights = data["rights"]as? JSONDictionary, videoRights = rights["label"] as? String {
            self._videoRights = videoRights
        } else {
            _videoRights = ""
        }
        
        // video price
        if let price = data["im:price"] as? JSONDictionary, videoPrice = price["label"] as? String {
            self._videoPrice = videoPrice
        } else {
            _videoPrice = ""
        }
        
        // video Artist
        if let artist = data["im:artist"] as? JSONDictionary, videoArtist = artist["label"] as? String {
            self._videoArtist = videoArtist
        } else {
            _videoArtist = ""
        }
        
        // video Imid
        if let imid = data["id"] as? JSONDictionary, imidAttributes = imid["attributes"] as? JSONDictionary, videoImid = imidAttributes["im:id"] as? String {
            self._videoImid = videoImid
        } else {
            _videoImid = ""
        }
        
        // video genre
        if let genre = data["category"] as? JSONDictionary, videoTerm = genre["attributes"] as? JSONDictionary, videoGenre = videoTerm["term"] as? String {
            self._videoGenre = videoGenre
        } else {
            _videoGenre = ""
        }
        
        // video Link to iTunes
        if let linkToiTunes = data["id"] as? JSONDictionary, videoLinkToiTunes = linkToiTunes["label"] as? String {
            self._videoLinkToiTunes = videoLinkToiTunes
        } else {
            _videoLinkToiTunes = ""
        }
        
        // video release date
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary, releaseDateAttributes = releaseDate["attributes"] as? JSONDictionary, videoReleaseDate = releaseDateAttributes["label"] as? String {
            self._videoReleaseDate = videoReleaseDate
        } else {
            _videoReleaseDate = ""
        }
    }
    
} // closes Video
