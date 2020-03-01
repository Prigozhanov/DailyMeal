//
//  Created by Vladimir on 3/1/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit

public extension CLLocationCoordinate2D {
	func middleLocationWith(_ location: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
		
		let lon1 = longitude * .pi / 180
		let lon2 = location.longitude * .pi / 180
		let lat1 = latitude * .pi / 180
		let lat2 = location.latitude * .pi / 180
		let dLon = lon2 - lon1
		let x = cos(lat2) * cos(dLon)
		let y = cos(lat2) * sin(dLon)
		
		let lat3 = atan2( sin(lat1) + sin(lat2), sqrt((cos(lat1) + x) * (cos(lat1) + x) + y * y) )
		let lon3 = lon1 + atan2(y, cos(lat1) + x)
		
		let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat3 * 180 / .pi,longitude: lon3 * 180 / .pi)
		return center
	}
}
