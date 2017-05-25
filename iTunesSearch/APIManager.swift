//
//  APIManager.swift
//  iTunesSearch
//
//  Created by LinuxPlus on 5/13/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import Foundation

class APIManager {
    var delegate :ApiManagerProtocol!
    init(paramDelegate: ApiManagerProtocol) {
       self.delegate = paramDelegate
    }
    typealias JsonDictionary = [String: Any]
    
    // get All itunes search items from url
    func getItunesItems(url:URL){
        var allItems :[iTunesItem] = [iTunesItem]()
        let urlRequst = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5000)
        let session = URLSession.shared
        
        //urlsession task to get all json data
        let task = session.dataTask(with: urlRequst){
            data, response, error in
            guard error == nil else {return}
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                do {
                    let array = try JSONSerialization.jsonObject(with: data, options: []) as? JsonDictionary
                    //convert json to array of dictionaries
                    let iTunesData = array?["results"] as! [JsonDictionary]
                    // store each dictionary in array
                    
                    for dictionary in iTunesData{
                        if let item = self.configureItunesItem(dictionary){
                            allItems.append(item)
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate.getDataFromItunesDidFinish(itunesItems: allItems)
                    }
                    // execute SearchViewController protocol method to reload tableView with data returned from JSON
                    
                } catch let parseError as NSError {
                    print( "JSONSerialization error: \(parseError.localizedDescription)\n")
                    return
                }
            }
            
        }
        task.resume()
    }
    
    
    // create iTunesItem object from dictionary contain all information
    private func configureItunesItem(_ dictionary: JsonDictionary) -> iTunesItem?{
        var item: iTunesItem?
        var mPrice:Double?
        var mGenre:String?
        
        
        guard let name = dictionary["trackName"] as? String,
            let artistName = dictionary["artistName"] as? String,
            let artworkSmallUrl = dictionary["artworkUrl60"] as? String,
            let artworkLargeUrl = dictionary["artworkUrl100"] as? String ,
            let storeUrl = dictionary["trackViewUrl"] as? String ,
            let kind = dictionary["kind"] as? String,
            let currency = dictionary["currency"] as? String
            else{
                return item
        }
        
       
        // handle price and genre in software and ebook media as they hava different keys
        if kind == "software" || kind == "ebook" {
            mPrice = dictionary["price"] as? Double
            if let genres = dictionary["genres"] as? [String]{
                mGenre = genres[0]
            }
        }else{
            mPrice = dictionary["trackPrice"] as? Double
            mGenre = dictionary["primaryGenreName"] as? String
        }
        
        // check price and genre
        guard let price = mPrice, let genre = mGenre else {
            return item
        }
        
        item = iTunesItem(name: name, artistName: artistName, artworkSmallUrl: artworkSmallUrl, artworkLargeUrl: artworkLargeUrl, storeUrl: storeUrl, kind: kind, currency: currency, price: price, genre: genre)
        return item
    }
}

protocol ApiManagerProtocol {
    func getDataFromItunesDidFinish(itunesItems: [iTunesItem])
}
