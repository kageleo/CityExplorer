//
//  ContentView.swift
//  CityExplorer
//
//  Created by 吉郷景虎 on 2020/08/20.
//  Copyright © 2020 Kagetora Yoshigo. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager()
    
    @State var currentAnnotation: MKPointAnnotation?
    
    @State var showPhotoGrid = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                MyMap(currentRegion: $locationManager.currentRegion, currentAnnotation: $currentAnnotation, showPhotoGrid: $showPhotoGrid)
                Button(action: {
                    self.locationManager.goToUserLocation()
                }) {
                    LocationButtonContent()
                }
            }
                .sheet(isPresented: $showPhotoGrid) {
                    PhotoGrid(latitudeToSearchFor: (self.currentAnnotation?.coordinate.latitude)!, longitudeToSearchFor: (self.currentAnnotation?.coordinate.longitude)!)
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Long-press to select location", displayMode: .inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LocationButtonContent: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
            Image(systemName: "location")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .clipped()
                .foregroundColor(.black)
                .padding(40)
        }
    }
}
