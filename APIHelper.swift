//
//  APIHelper.swift
//  CityExplorer
//
//  Created by 吉郷景虎 on 2020/08/21.
//  Copyright © 2020 Kagetora Yoshigo. All rights reserved.
//

import Foundation

let apiKey = "7dfe6c62067053461bde89f4985ec55f"

func generateFlickrURL(latitude: Double, longitude: Double, numberOfPhotos: Int) -> String {
    let url =  "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&lat=\(latitude)&lon=\(longitude)4&radius=1&radius_units=km&per_page=\(numberOfPhotos)&format=json&nojsoncallback=1"
    return url
}
