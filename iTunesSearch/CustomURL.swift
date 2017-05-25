//
//  CustomURL.swift
//  iTunesSearch
//
//  Created by LinuxPlus on 5/13/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import Foundation

public enum CustomURL{
    //four categories
    case music(String)
    case movie(String)
    case software(String)
    case ebook(String)
    
    // Base endpoint
    static let baseURLString = "https://itunes.apple.com/search?"
    
    //determine the media type
    var media: String{
        switch self {
        case .music(_): return "music"
        case .movie(_): return "movie"
        case .software(_): return "software"
        case .ebook(_): return "ebook"
        }
    }
    
    
    // configure URL for the four categories
    public func asUrlRequest() -> URL{
        let searchTerm : String = {
            switch self {
            case .music(let term),
                 .movie(let term),
                 .software(let term),
                 .ebook(let term): return term
            }
        }()
        
        var urlComponent = URLComponents(string: CustomURL.baseURLString)
        urlComponent?.queryItems?.append(URLQueryItem(name: "term", value: searchTerm))
        urlComponent?.queryItems?.append(URLQueryItem(name: "media", value: self.media))
        
        print((urlComponent?.url)!)
        return (urlComponent?.url)!
    }
    
}
