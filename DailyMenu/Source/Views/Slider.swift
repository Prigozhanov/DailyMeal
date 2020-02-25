//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class Slider: UISlider {
    
    init() {
        super.init(frame: .zero)
        
        setThumbImage(Images.Icons.thumb.image.kf.resize(to: CGSize(width: 15, height: 15), for: .aspectFill), for: .normal)
        minimumTrackTintColor = Colors.blue.color
        maximumTrackTintColor = Colors.lightGray.color
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.origin.x = 0
        rect.size.width = bounds.size.width
        rect.size.height = 1
        return rect
    }
    
    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()!
        var path = UIBezierPath(roundedRect: CGRect(
            origin: CGPoint(x: frame.origin.x, y: trackRect(forBounds: bounds).midY),
            size: CGSize(width: bounds.width, height: 1)
        ), cornerRadius: 1)
        
        ctx.addPath(path.cgPath)
        
        ctx.setFillColor(maximumTrackTintColor!.cgColor)
        ctx.fillPath()
        
        path = UIBezierPath(roundedRect: CGRect(x: 0, y: trackRect(forBounds: bounds).midY - 1,
                                                width: bounds.width * CGFloat((value / maximumValue)),
                                                height: 3), cornerRadius: 1)
        ctx.addPath(path.cgPath)
        ctx.setFillColor(minimumTrackTintColor!.cgColor)
        ctx.fillPath()
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        setNeedsDisplay()
        return super.continueTracking(touch, with: event)
    }

}
