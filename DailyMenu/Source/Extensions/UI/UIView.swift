//
//  Created by Vladimir on 11/14/19.
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
    
    static func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.lightGray.color
        view.snp.makeConstraints { $0.height.equalTo(1) }
        return view
    }
    
    func tapAnimation(completion: VoidClosure? = nil) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                self?.transform = .identity
                }, completion: { _ in completion?() })
        }
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
