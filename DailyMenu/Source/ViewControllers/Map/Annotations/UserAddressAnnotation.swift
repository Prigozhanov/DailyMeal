//
//  Created by Vladimir on 3/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit

class UserAddressAnnotation: MKPointAnnotation {}

class UserAddressAnnotationView: MKAnnotationView {
	
	static let userAddressAnnotationReuseIdentifier = "userAddressAnnotationReuseIdentifier"
	
	override var annotation: MKAnnotation? {
		didSet {
			image = Images.Icons.mapPin1.image
			tintColor = Colors.blue.color
		}
	}
	
}
