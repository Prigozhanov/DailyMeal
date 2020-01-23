//
//  Created by Vladimir on 1/14/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class Style {
    
    static func addBlueCorner(_ vc: UIViewController) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 250))
        view.backgroundColor = Colors.blue.color
        view.alpha = 0.08
        vc.view.addSubview(view)
        view.center = CGPoint(x: vc.view.frame.maxX, y: 0)
        view.transform = CGAffineTransform(rotationAngle: 0.45)
    }
    
    static func addBlueGradient(_ view: UIView) {
        view.insertSubview(GradientView(parentView: view), at: 0)
    }
    
}
