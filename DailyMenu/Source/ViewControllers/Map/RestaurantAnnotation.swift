//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit
import Networking

class RestaurantAnnotation: MKPointAnnotation {
    
    let restaurant: Restaurant
    let onSelectAction: (Restaurant) -> Void
    
    init(restaurant: Restaurant, coordinate: CLLocationCoordinate2D, onSelectAction: @escaping (Restaurant) -> Void) {
        self.restaurant = restaurant
        self.onSelectAction = onSelectAction
        
        super.init()
        
        self.coordinate = coordinate
    }
    
    
}
