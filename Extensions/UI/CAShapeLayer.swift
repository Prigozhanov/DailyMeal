//
//  Created by Vladimir on 2/28/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

public extension CAShapeLayer {
	func drawCircleAtLocation(location: CGPoint, radius: CGFloat, color: UIColor) {
		strokeColor = color.cgColor
		let origin = CGPoint(x: location.x - radius, y: location.y - radius)
		path = UIBezierPath(ovalIn: CGRect(origin: origin, size: CGSize(width: radius * 2, height: radius * 2))).cgPath
		fillColor = color.cgColor
	}
}
