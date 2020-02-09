//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation
import Services
import CoreLocation

protocol MapViewModel {
    var shouldShowPin: Bool { get }
    
     func getUserLocation() -> CLLocationCoordinate2D?
}

class MapViewModelImplementation: MapViewModel {
    
    private let locationService: LocationService
    private let context: AppContext
    
    let shouldShowPin: Bool
    
    init(shouldShowPin: Bool = false) {
        context = AppDelegate.shared.context
        locationService = context.locationService
        
        self.shouldShowPin = shouldShowPin
        
        locationService.startUpdatingLocation { _ in
            
        }
    }
    
    deinit {
        locationService.stopUpdatingLocation()
    }
    
    func getUserLocation() -> CLLocationCoordinate2D? {
        return locationService.currentCoordinate
    }
    
}
