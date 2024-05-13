//
//  MapViewDelategs.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
import CoreLocation
import GoogleMaps
//extension YBMapView : CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//            map.isMyLocationEnabled = true
//            map.settings.myLocationButton = true
//        }
//    }
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            if let location = locations.first {
//                let camera = GMSCameraPosition(latitude: location.coordinate.latitude,
//                                               longitude: location.coordinate.longitude,
//                                               zoom: 15)
//                map.animate(to: camera)
//                
//                locationManager.stopUpdatingLocation()
//            }
//        }
//    }
//
