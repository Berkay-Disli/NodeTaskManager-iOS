//
//  CLLocation.swift
//  Abonesepeti
//
//  Created by Marjan on 8/13/1400 AP.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 42.361145, longitude: -71.057083)

    static var getDefaultLocation: CLLocationCoordinate2D {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let defaultLocation = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 41.09611863505988, longitude: locationManager.location?.coordinate.longitude ?? 29.036865915727507)
        return defaultLocation
    }
}
