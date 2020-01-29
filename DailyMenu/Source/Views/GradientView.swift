//
//  Created by Vladimir on 1/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    enum Direction {
        case vertical, horizontal, custom([NSNumber]), points(CGPoint, CGPoint)
    }
    
    init(parentView: UIView, colors: [CGColor], direction: Direction) {
        super.init(frame: parentView.bounds)
        
        isUserInteractionEnabled = false
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        switch direction {
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.locations = [0, 1]
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.locations = [0, 1]
        case let .custom(locations):
            gradientLayer.locations = locations
        case let .points(startPoint, endPoint):
            gradientLayer.startPoint = startPoint
            gradientLayer.endPoint = endPoint
        }
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        parentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    
}
