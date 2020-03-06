//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit
import Networking

class RestaurantAnnotation: MKPointAnnotation {
    
    let restaurant: RestaurantData
    let onSelectAction: (RestaurantData) -> Void
    
    init(restaurant: RestaurantData, coordinate: CLLocationCoordinate2D, onSelectAction: @escaping (RestaurantData) -> Void) {
        self.restaurant = restaurant
        self.onSelectAction = onSelectAction
        
        super.init()
        
        self.coordinate = coordinate
    }
    
}
