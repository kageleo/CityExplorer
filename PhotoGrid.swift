//
//  PhotoGrid.swift
//  CityExplorer
//
//  Created by 吉郷景虎 on 2020/08/21.
//  Copyright © 2020 Kagetora Yoshigo. All rights reserved.
//

import SwiftUI
import QGrid

struct PhotoGrid: View {
    
    var latitudeToSearchFor: Double
    var longitudeToSearchFor: Double
    
    @ObservedObject var downloadManager = DownloadManager()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if self.downloadManager.imagesFetched && self.downloadManager.imageCells.isEmpty {
                    VStack {
                        Image(systemName: "questionmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width/12, height: geometry.size.width/8)
                        Text("No photos found at this location ):")
                            .padding()
                    }
                } else if self.downloadManager.imagesFetched {
                    QGrid(self.downloadManager.imageCells, columns: 2, vSpacing: 0, hSpacing: 0, vPadding: 0, hPadding: 0, content: { cell in
                        cell.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width/2, height: geometry.size.width/2)
                            .clipped()
                    })
                } else {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.gray)
                            .frame(width: 320, height: 12)
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.blue)
                            .frame(width: 320*CGFloat(self.downloadManager.percentLoaded), height: 12)
                    }
                }
            }
        }
            // PhotoGirdが表示された時
            .onAppear(perform: {
                
                self.downloadManager.startDownload(flickrURL: generateFlickrURL(latitude: self.latitudeToSearchFor, longitude: self.longitudeToSearchFor, numberOfPhotos: 40))
            })
            // PhotoGirdが閉じられた時
            .onDisappear(perform: {
                self.downloadManager.clean()
            })
    }
}

struct PhotoGrid_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGrid(latitudeToSearchFor: 48.864716, longitudeToSearchFor: 2.349014)
    }
}
