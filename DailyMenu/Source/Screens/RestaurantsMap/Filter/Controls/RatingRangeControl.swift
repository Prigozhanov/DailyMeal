//
//  Created by Vladimir on 2/21/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RatingRangeControl: UIControl {
    
    private var previousLocation = CGPoint()
    
    var minimumValue: CGFloat =  0
    var maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0.2
    var upperValue: CGFloat = 0.8
    
    private let trackLayer = RatingRangeTrackingLayer()
    
    let trackTintColor = Colors.lightGray.color
    let trackHighlightTintColor = Colors.blue.color
    
    private let lowerThumbView = RatingRangeThumb(frame: CGRect(x: 0, y: 0, width: 2, height: 0))
    private let upperThumbView = RatingRangeThumb(frame: CGRect(x: 0, y: 0, width: 2, height: 0))
    
    let valueChanged: (RatingRangeControl) -> Void
    
    init(valueChanged: @escaping (RatingRangeControl) -> Void) {
        self.valueChanged = valueChanged
        
        super.init(frame: .zero)
        
        layer.addSublayer(trackLayer)
        trackLayer.contentsScale = UIScreen.main.scale
        trackLayer.slider = self
        
        lowerThumbView.backgroundColor = Colors.blue.color
        addSubview(lowerThumbView)
        upperThumbView.backgroundColor = Colors.blue.color
        addSubview(upperThumbView)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func updateLayerFrames() {
        trackLayer.frame = bounds
        trackLayer.updateContents()
        
        lowerThumbView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                      size: CGSize(width: 2, height: frame.height))
        upperThumbView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                      size: CGSize(width: 2, height: frame.height))
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * (value / maximumValue)
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - 1
        return CGPoint(x: x, y: (bounds.height - frame.height) / 2.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayerFrames()
    }
    
    
    internal class RatingRangeThumb: UIView {
        
        var isHighlighted: Bool = false
        
    }
    
}

extension RatingRangeControl {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        if (upperThumbView.center.x - previousLocation.x) > (previousLocation.x - lowerThumbView.center.x) {
            lowerThumbView.isHighlighted = true
        } else {
            upperThumbView.isHighlighted = true
        }
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        
        previousLocation = location
        
        if lowerThumbView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                    upperValue: upperValue)
        } else if upperThumbView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                    upperValue: maximumValue)
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
        upperThumbView.isHighlighted = false
        lowerThumbView.isHighlighted = false
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
    
}

class RatingRangeTrackingLayer: CALayer {
    
    weak var slider: RatingRangeControl?
    
    let image = Images.starsStack.image
    
    override init() {
        super.init()
        contentsGravity = .resizeAspect
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func updateContents() {
        guard let slider = slider else {
            return
        }
        contents = image.withHorizontalFill(
            lowerBound: slider.lowerValue / slider.maximumValue,
            upperBound: slider.upperValue / slider.maximumValue,
            highlightingColor: slider.trackHighlightTintColor
        ).cgImage
    }
    
}
