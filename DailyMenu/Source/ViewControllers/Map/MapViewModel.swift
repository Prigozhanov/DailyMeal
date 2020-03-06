//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Services
import CoreLocation

protocol MapViewModel {
    var shouldShowPin: Bool { get }
    var onRegionDidChange: ((CLLocationCoordinate2D) -> Void)? { get }
    
    func getUserLocation() -> CLLocationCoordinate2D?
	func getUserAddressLocation() -> CLLocationCoordinate2D?
	func updateUserLocation(completion: @escaping (CLLocationCoordinate2D) -> Void)
	func getAddresByCoordinates(lat: Double, lon: Double, completion: @escaping (String) -> Void)
}

class MapViewModelImplementation: MapViewModel {
    
    private let context: AppContext
	private let locationService: LocationService
	private let userDefaultsService: UserDefaultsService
    
    let shouldShowPin: Bool
    
    var onRegionDidChange: ((CLLocationCoordinate2D) -> Void)?
    
    init(shouldShowPin: Bool = false, onRegionDidChange: ((CLLocationCoordinate2D) -> Void)? = nil) {
        context = AppDelegate.shared.context
        locationService = context.locationService
		userDefaultsService = context.userDefaultsService
        
        self.shouldShowPin = shouldShowPin
        self.onRegionDidChange = onRegionDidChange
        
        locationService.startUpdatingLocation { _ in

        }
    }
    
    deinit {
        locationService.stopUpdatingLocation()
    }
    
    func getUserLocation() -> CLLocationCoordinate2D? {
        return locationService.currentCoordinate
    }
	
	func getUserAddressLocation() -> CLLocationCoordinate2D? {
		guard let lat = userDefaultsService.getValueForKey(key: .addressLat) as? Double,
			let lon = userDefaultsService.getValueForKey(key: .addressLon) as? Double else {
				return nil
		}
		return CLLocationCoordinate2D(latitude: lat, longitude: lon)
	}
	
	func updateUserLocation(completion: @escaping (CLLocationCoordinate2D) -> Void) {
		locationService.startUpdatingLocation(onUpdate: completion)
	}
	
	func getAddresByCoordinates(lat: Double, lon: Double, completion: @escaping (String) -> Void) {
		let req = context.networkService.requestFactory.getGeocode(string: "\(lon),\(lat)")
		
		context.networkService.send(request: req) { result, _ in
			switch result {
			case let .success(geodata):
				if let address = geodata?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.name {
					completion(address)
				}
			case .failure:
				logError(message: "Address not found")
			}
		}
	}
    
}
