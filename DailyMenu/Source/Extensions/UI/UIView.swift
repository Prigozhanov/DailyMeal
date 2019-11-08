//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit


extension UIView {
  
  func setRoundCorners(_ cornerRadius: CGFloat) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
  }
  
  func setRoundCorners(_ cornerRadius: CGFloat, maskedCorners: CACornerMask) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
    layer.maskedCorners = maskedCorners
  }
  
  func setShadow(offset: CGSize, opacity: Float, radius: CGFloat) {
    clipsToBounds = false
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = offset
    layer.shadowOpacity = opacity
    layer.shadowRadius = radius
  }
  
  func setBorder(width: CGFloat, color: CGColor) {
    layer.borderColor = color
    layer.borderWidth = width
  }
  
}
