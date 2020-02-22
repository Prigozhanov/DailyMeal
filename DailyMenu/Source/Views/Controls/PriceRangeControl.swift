//
//  Created by Vladimir on 2/21/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class PriceRangeControl: UIControl {
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    private var previousLocation = CGPoint()
    
    var minimumValue: CGFloat =  0
    var maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0.2
    var upperValue: CGFloat = 0.8
    
    private let trackLayer = PriceRangeTrackLayer()
    
    let trackTintColor = Colors.lightGray.color
    let trackHighlightTintColor = Colors.blue.color
    
    private let thumbImage = Images.Icons.thumb.image
    
    private let backgroundImage = Images.priceRangeBackground.image
    private let backgroundImageView = UIImageView()
    
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    
    let valueChanged: (PriceRangeControl) -> Void
    
    init(valueChanged: @escaping (PriceRangeControl) -> Void) {
        self.valueChanged = valueChanged
        
        super.init(frame: .zero)
        
        backgroundImageView.image = backgroundImage
        addSubview(backgroundImageView)
        
        layer.addSublayer(trackLayer)
        trackLayer.contentsScale = UIScreen.main.scale
        trackLayer.slider = self
        
        lowerThumbImageView.image = thumbImage
        addSubview(lowerThumbImageView)
        upperThumbImageView.image = thumbImage
        addSubview(upperThumbImageView)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func updateLayerFrames() {
        
        trackLayer.frame = CGRect(
            origin: CGPoint(x: 0, y: bounds.maxY - thumbImage.size.height / 2),
            size: CGSize(width: bounds.width, height: 3)
        )
        trackLayer.setNeedsDisplay()
        
        backgroundImageView.frame = CGRect(
            origin: bounds.origin,
            size: CGSize(
                width: bounds.width,
                height: bounds.height - thumbImage.size.height / 2
            )
        )
        backgroundImageView.image = backgroundImage.withHorizontalFill(
            lowerBound: lowerValue,
            upperBound: upperValue,
            highlightingColor: Colors.blue.color
        )
        
        lowerThumbImageView.frame = CGRect(
            origin: thumbOriginForValue(lowerValue),
            size: thumbImage.size
        )
        upperThumbImageView.frame = CGRect(
            origin: thumbOriginForValue(upperValue),
            size: thumbImage.size
        )
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * (value / maximumValue)
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: bounds.maxY - thumbImage.size.height)
    }
    
}

extension PriceRangeControl {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(
                lowerValue, toLowerValue: minimumValue,
                upperValue: upperValue
            )
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(
                upperValue, toLowerValue: lowerValue,
                upperValue: maximumValue
            )
        }
        
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        valueChanged(self)
        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        upperThumbImageView.isHighlighted = false
        lowerThumbImageView.isHighlighted = false
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
    
    
}

class PriceRangeTrackLayer: CALayer {
    
    weak var slider: PriceRangeControl?
    
    override func draw(in ctx: CGContext) {
        guard let slider = slider else {
            return
        }
        
        let path = UIBezierPath(roundedRect: CGRect(
            origin: bounds.origin,
            size: CGSize(width: bounds.width, height: 1)
        ), cornerRadius: cornerRadius)
        
        ctx.addPath(path.cgPath)
        
        ctx.setFillColor(slider.trackTintColor.cgColor)
        ctx.fillPath()
        
        ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
        let lowerValuePosition = slider.positionForValue(slider.lowerValue)
        let upperValuePosition = slider.positionForValue(slider.upperValue)
        let rect = CGRect(x: lowerValuePosition, y: 0,
                          width: upperValuePosition - lowerValuePosition,
                          height: bounds.height)
        ctx.fill(rect)
    }
    
}
