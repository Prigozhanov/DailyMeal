//
//  Created by Vladimir on 2/24/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit

class UserLocationAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            image = Images.Icons.userLocation.image
        }
    }
    
}
