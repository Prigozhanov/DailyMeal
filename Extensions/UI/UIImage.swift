//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func withHorizontalFill(ratio: CGFloat, highlightingColor: UIColor, fillColor: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: rect)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setBlendMode(CGBlendMode.sourceIn)
        
        context.setFillColor(highlightingColor.cgColor)
        
        let rectToFill = CGRect(x: 0, y: 0, width: size.width * ratio, height: size.height)
        context.fill(rectToFill)
        
        context.setFillColor(fillColor.cgColor)
        let secondRectToFill = CGRect(x: size.width * ratio, y: 0, width: size.width * (1 - ratio), height: size.height)
        context.fill(secondRectToFill)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func withHorizontalFill(lowerBound: CGFloat,
                            upperBound: CGFloat,
                            highlightingColor: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: rect)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setBlendMode(CGBlendMode.sourceIn)
        
        context.setFillColor(highlightingColor.cgColor)
        
        let rectToFill = CGRect(
            x: size.width * lowerBound,
            y: 0.5,
            width: (size.width * upperBound) - size.width * lowerBound,
            height: size.height
        
        )
        context.fill(rectToFill)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
