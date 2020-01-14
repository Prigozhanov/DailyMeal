//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

fileprivate var pointer = NSObject()

extension UIButton {
    func setActionHandler(controlEvents control :UIControl.Event, ForAction action: @escaping (UIButton) -> Void) {
        let actionWrapper = ActionWrapper(action)
        
        objc_setAssociatedObject(self, &pointer, actionWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        removeTarget(self, action: nil, for: .allEvents)
        addTarget(self, action: #selector(invokeAction), for: control)
    }
    
    @objc func invokeAction() {
        if let obj = objc_getAssociatedObject(self, &pointer) as? ActionWrapper {
            obj.action(self)
        }
    }
}

class ActionWrapper {
    var action: (UIButton) -> Void
    
    init(_ action: @escaping (UIButton) -> Void) {
        self.action = action
    }
}

extension UIButton {
    
    static func makeCommonButton(_ text: String? = nil, action: @escaping (UIButton) -> Void) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(Colors.blue.color, for: .normal)
        button.setActionHandler(controlEvents: .touchUpInside, ForAction: action)
        return button
    }
    
    static func makeCustomButton(
        title: String?,
        backgroundColor: UIColor! = .clear,
        titleColor: UIColor! = Colors.black.color,
        cornerRadius: CGFloat! = 0,
        font: UIFont? = FontFamily.regular,
        action: @escaping (UIButton) -> Void
    ) -> UIButton {
        let button = UIButton(frame: .zero)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.titleLabel?.font = font
        button.setActionHandler(controlEvents: .touchUpInside, ForAction: action)
        return button
    }
    
    static func makeActionButton(_ text: String, action: @escaping (UIButton) -> Void) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = Layout.cornerRadius
        button.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(300)
        }
        button.setTitle(text, for: .normal)
        button.setActionHandler(controlEvents: .touchUpInside, ForAction: action)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.blue.color.cgColor, Colors.lightBlue.color.cgColor]
        gradientLayer.locations = [0, 1]
        button.layer.addSublayer(gradientLayer)
        return button
    }
    
    static func makeNotificationButton() -> UIButton {
        let button = UIButton.makeCommonButton { _ in }
        button.setImage(Images.Icons.notification.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = Colors.white.color
        return button
    }
    
    static func makeBackButton(_ vc: UIViewController) -> UIButton {
        let button = UIButton.makeCommonButton { [unowned vc] _ in
            vc.navigationController?.popViewController(animated: true)
        }
        button.setImage(Images.Icons.back.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = Colors.white.color
        return button
    }
    
    static func makeImageButton(image: UIImage, action: @escaping (UIButton) -> Void) -> UIButton {
        let button = UIButton.makeCommonButton(action: action)
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        return button
    }
    
}
