//
//  Created by Vladimir on 2/7/20.
//  Copyright © 2020 epam. All rights reserved.
//

import CoreLocation
import os.log

public protocol LocationServiceHolder {
    
    var locationService: LocationService { get }
    
}

public protocol LocationService {
    
    var currentCoordinate: CLLocationCoordinate2D? { get }
    
    func startUpdatingLocation(onUpdate: @escaping (CLLocationCoordinate2D) -> Void)
    
    func stopUpdatingLocation()
    
    func getAddressesListByString(string: String, completion: @escaping ([String]) -> Void)
    
}

public class LocationServiceImplementation: NSObject, LocationService {
    
    public var currentCoordinate: CLLocationCoordinate2D?
    
    private let locationManager: CLLocationManager
    private let geocoder: CLGeocoder
    
    private var onUpdate: ((CLLocationCoordinate2D) -> Void)?
    
    override public init() {
        locationManager = CLLocationManager()
        geocoder = CLGeocoder()
        
        super.init()
        
        locationManager.delegate = self
    }
    
    public func startUpdatingLocation(onUpdate: @escaping (CLLocationCoordinate2D) -> Void) {
        self.onUpdate = onUpdate
        locationManager.startUpdatingLocation()
        os_log("[LOCATION] %s", "Location manager started updating locations")
    }
    
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        os_log("[LOCATION] %s", "Location manager started updating locations")
    }
    
    public func getAddressesListByString(string: String, completion: @escaping ([String]) -> Void) {
        geocoder.geocodeAddressString(string) { (placemarks, _) in
            let addresses = placemarks?.map({ "\($0.country ?? ""), \($0.name ?? "")" })
            completion(addresses ?? [])
        }
    }
    
}

extension LocationServiceImplementation: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentCoordinate = location.coordinate
            onUpdate?(location.coordinate)
        }
    }
    
}
