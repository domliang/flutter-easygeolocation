//
//  LocationService.swift
//  geolocation
//
//  Created by 小强 on 2018/12/14.
//

import CoreLocation
import Foundation
import Flutter

class LocationService: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    init(resultHandler: @escaping FlutterResult, arguments: Any?) {
        //        super.init(delegate: self)
        self.resultHandler = resultHandler
        self.arguments = arguments
    }
    let arguments: Any?
    let resultHandler: FlutterResult
    public func getCurrentPosition() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
            resultHandler([
                "status": "notDetermined",
                ])
        } else if CLLocationManager.authorizationStatus() == .denied {
            resultHandler([
                "status": "denied",
                ])
            NSLog("Location services were previously denied")
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            NSLog("start updating")
            locationManager?.startUpdatingLocation()
        } else {
            NSLog("in else")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        NSLog("Did location updates is called")
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        
        if(locationManager != nil) {
            locationManager!.stopUpdatingLocation()
            locationManager = nil
        }
        resultHandler([
            "status": "ok",
            "latitude": coord.latitude,
            "longitude": coord.longitude,
            ])
    }
    
    private func locationManager(manager: CLLocationManager!,
                                 didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        var shouldIAllow = false
        var locationStatus: String
        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager?.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Did location updates is called but failed getting location \(error)")
        if(locationManager != nil) {
            locationManager!.stopUpdatingLocation()
            locationManager = nil
        }
    }
}
