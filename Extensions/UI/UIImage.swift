//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func withHorizontalFill(ratio: CGFloat, fillColor: UIColor, secondColor: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: rect)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setBlendMode(CGBlendMode.sourceIn)
        
        context.setFillColor(fillColor.cgColor)
        
        let rectToFill = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height)
        context.fill(rectToFill)
        
        context.setFillColor(secondColor.cgColor)
        let secondRectToFill = CGRect(x: size.width * ratio, y: 0, width: size.width * (1 - ratio), height: size.height)
        context.fill(secondRectToFill)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
