//
//  DownloadManager.swift
//  CityExplorer
//
//  Created by 吉郷景虎 on 2020/08/21.
//  Copyright © 2020 Kagetora Yoshigo. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire
import AlamofireImage

class DownloadManager: ObservableObject {
    
    @Published var imagesFetched = false
    
    @Published var percentLoaded = 0.0
    
    var imageURLs = [String]()
    var imageCells = [ImageCell]()
    
    func startDownload(flickrURL: String) {
        print("Started fetching images from Flickr.")
        
        retrieveImageURLS(fromFlickrURL: flickrURL) { (finished) in
            if finished {
                print("All image URLs retrieved.")
                self.retrieveImages { (finished) in
                    if finished {
                        print("Images succesfully downloaded")
                        self.imagesFetched = true
                    }
                }
            }
        }
    }
    
    
    
    
//    func retrieveImageURLS(fromFlickrURL: String, handler: @escaping (_ status: Bool) -> ()) {
//        Alamofire.request(fromFlickrURL).responseJSON { (response) in
//            guard let json = response.result.value as? Dictionary<String, AnyObject> else {
//                print("Json could not be created.")
//                return
//            }
//            let motherPhotosDict = json["photos"] as! Dictionary<String, AnyObject>
//            let photoDicts = motherPhotosDict["photo"] as! [Dictionary<String, AnyObject>]
//            for photo in photoDicts {
//                let photoURL = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_b.jpg"
//                self.imageURLs.append(photoURL)
//            }
//            handler(true)
//        }
//    }
    
    func retrieveImageURLS(fromFlickrURL: String, handler: @escaping (_ status: Bool) -> ()) {
        AF.request(fromFlickrURL).responseJSON { (response) in
            switch response.result {
            case let .success(value):
                if let json = value as? Dictionary<String, AnyObject> {
                    let motherPhotosDict = json["photos"] as! Dictionary<String, AnyObject>
                    let photoDicts = motherPhotosDict["photo"] as! [Dictionary<String, AnyObject>]
                    for photo in photoDicts {
                        let photoURL = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_b.jpg"
                        self.imageURLs.append(photoURL)
                    }
                    handler(true)
                }
            case let .failure(error):
                print("Json could not be created.", error)
            }
        }
    }
    
    
    
    
    
//    func retrieveImages(handler: @escaping(_ state: Bool) -> ()) {
//
//        guard !imageURLs.isEmpty else {
//            return handler(true)
//        }
//
//        for url in imageURLs {
//            Alamofire.request(url).responseImage { (response) in
//                guard let image = reponse.result.value else {
//                    print("Image could not be fetched from \(url).")
//                    return
//                }
//                self.imageCells.append(ImageCell(image: Image(uiImage: image)))
//                withAnimation() {
//                    self.percentLoaded = Double(self.imageCells.count)/Double(self.imageURLs.count)
//                }
//                print("\(self.imageCells.count)/\(self.imageURLs.count) images downloaded.")
//                if self.imageCells.count == self.imageURLs.count {
//                    handler(true)
//                }
//
//            }
//        }
//    }
    
    func retrieveImages(handler: @escaping(_ status: Bool) -> ()) {
        
        guard !imageURLs.isEmpty else { return handler(true) }
        
        for url in imageURLs {
            AF.request(url).responseImage { (response) in
                switch response.result {
                case let .success(retrievedImage):
                    self.imageCells.append(ImageCell(image: Image(uiImage: retrievedImage)))
                    withAnimation {
                        self.percentLoaded = Double(self.imageCells.count)/Double(self.imageURLs.count)
                    }
                    print("\(self.imageCells.count)/\(self.imageURLs.count) images downloaded.")
                    if self.imageCells.count == self.imageURLs.count {
                        handler(true)
                    }
                case let .failure(error):
                    print("Image could not be fetched from \(url).", error)
                }
            }
        }
    }
    
    
    
    
    
    
    func clean() {
        imageURLs.removeAll()
        imageCells.removeAll()
        percentLoaded = 0.0
    }
    
}
