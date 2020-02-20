//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit

class RestaurantAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? RestaurantAnnotation else { return }
            
            image = Images.Icons.disc.image
            
            canShowCallout = true
            
            let annotationCalloutView = RestaurantCalloutView(
                item: RestaurantCalloutView.Item(
                    imageSrc: annotation.restaurant.src,
                    title: annotation.restaurant.chainLabel,
                    rating: Double(annotation.restaurant.rate) ?? 0
                )
            )
            annotationCalloutView.addGestureRecognizer(BlockTap(action: { _ in
                annotation.onSelectAction(annotation.restaurant)
            }))
            
            detailCalloutAccessoryView = annotationCalloutView
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            image = Images.Icons.disc.image.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .fill)
        } else {
            image = Images.Icons.disc.image
        }
    }
}
