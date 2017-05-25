//
//  iTunesItem.swift
//  iTunesSearch
//
//  Created by LinuxPlus on 5/10/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import Foundation

class iTunesItem{
    var name = ""
    var artistName = ""
    var artworkSmallUrl = ""
    var artworkLargeUrl = ""
    var storeUrl = ""
    var kind = ""
    var currency = ""
    var price = 0.0
    var genre = ""
    
    init(name:String,artistName:String, artworkSmallUrl:String, artworkLargeUrl:String, storeUrl:String, kind:String, currency:String, price:Double, genre:String) {
        self.name = name
        self.artistName = artistName
        self.artworkSmallUrl = artworkSmallUrl
        self.artworkLargeUrl = artworkLargeUrl
        self.storeUrl = storeUrl
        self.kind = kind
        self.currency = currency
        self.price = price
        self.genre = genre
    }
}

