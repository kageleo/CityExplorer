//
//  LocationManager.swift
//  CityExplorer
//
//  Created by 吉郷景虎 on 2020/08/21.
//  Copyright © 2020 Kagetora Yoshigo. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: ObservableObject {
    
    @Published var currentRegion = MKCoordinateRegion(center: CLLocation(latitude: 48.864716, longitude: 2.349014).coordinate, latitudinalMeters: CLLocationDistance(10000), longitudinalMeters: CLLocationDistance(10000))
    
    var userLocationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    func requestPermission() {
        if self.authorizationStatus == .notDetermined {
            self.userLocationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func goToUserLocation() {
        guard let userLocation = userLocationManager.location?.coordinate else {
            return
        }
        
        currentRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: CLLocationDistance(1000), longitudinalMeters: CLLocationDistance(1000))
    }
    
    init() {
        requestPermission()
        
        guard let userLocation = userLocationManager.location?.coordinate else {
            return
        }
        
        currentRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: CLLocationDistance(1000), longitudinalMeters: CLLocationDistance(1000))
    }
}
