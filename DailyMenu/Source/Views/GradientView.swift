//
//  Created by Vladimir on 1/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    init(parentView: UIView) {
        super.init(frame: parentView.bounds)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.blue.color.cgColor, Colors.blue2.color.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        parentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    
}
