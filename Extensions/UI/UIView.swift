//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({self.addSubview($0)})
    }
}

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

extension UIView {
    static func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.lightGray.color
        view.snp.makeConstraints { $0.height.equalTo(1) }
        return view
    }
    
    static func makeDashedSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 3)
        
        return view
    }
}

extension UIView {
    func tapAnimation(completion: VoidClosure? = nil) {
        UIView.animateKeyframes(withDuration: 0.2, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1) { [weak self] in
                self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) { [weak self] in
                self?.transform = .identity
            }
        }) { _ in completion?() }
    }
    
    func shakeAnimation(completion: VoidClosure? = nil) {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.repeatCount = 2
        animation.duration = 0.1
        animation.fromValue = self.center.x + 5
        animation.toValue = self.center.x - 5
        animation.autoreverses = true
        layer.add(animation, forKey: "postion.x")
    }
    
    func startRotating(duration: CFTimeInterval = 1, repeatCount: Float = Float.infinity, clockwise: Bool = true) {
        if layer.animation(forKey: "transform.rotation.z") != nil { return }
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        let direction = clockwise ? 1.0 : -1.0
        rotation.fromValue = NSNumber(value: 0)
        rotation.toValue = NSNumber(value: .pi * 2 * direction)
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = repeatCount
        layer.add(rotation, forKey: "transform.rotation.z")
    }
    
    func stopRotating() {
        layer.removeAnimation(forKey: "transform.rotation.z")
    }
    
}
