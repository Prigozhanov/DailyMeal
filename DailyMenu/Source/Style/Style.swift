//
//  Created by Vladimir on 1/14/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class Style {
    
    static func addBlueCorner(_ vc: UIViewController) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 250))
        view.backgroundColor = Colors.blue.color
        view.alpha = 0.08
        vc.view.addSubview(view)
        view.center = CGPoint(x: vc.view.frame.maxX, y: 0)
        view.transform = CGAffineTransform(rotationAngle: 0.45)
        vc.view.clipsToBounds = true
    }
    
    static func addBlueGradient(_ view: UIView) {
        if let gradient = view.subviews.first(where: { $0 is GradientView }) {
            gradient.removeFromSuperview()
        }
        view.insertSubview(
            GradientView(parentView: view,
                         colors: [Colors.blue.color.cgColor, Colors.blue2.color.cgColor],
                         direction: .points(CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 0))),
            at: 0)
    }
    
    static func addBlackGradient(_ view: UIView) {
        if let gradient = view.subviews.first(where: { $0 is GradientView }) {
            gradient.removeFromSuperview()
        }
        view.insertSubview(
            GradientView(parentView: view,
                         colors: [Colors.black.color.cgColor, UIColor.clear.cgColor],
                         direction: .custom([-1, 0.8])),
            at: 0)
    }
    
    static func addWhiteGradient(_ view: UIView) {
        if let gradient = view.subviews.first(where: { $0 is GradientView }) {
            gradient.removeFromSuperview()
        }
        view.insertSubview(
            GradientView(parentView: view,
                         colors: [Colors.white.color.cgColor, UIColor(white: 1, alpha: 0).cgColor],
                         direction: .custom([0, 1])),
            at: 0)
    }
    
    static func addShadow(for view: UIView, in parentView: UIView, cornerRadius: CGFloat) {
        let shadowView = UIView()
        shadowView.setRoundCorners(cornerRadius)
        shadowView.setShadow(offset: CGSize(width: 0, height: 10), opacity: 0.2, radius: 20)
        shadowView.backgroundColor = .white
        parentView.insertSubview(shadowView, belowSubview: view)
        shadowView.snp.makeConstraints { $0.edges.equalTo(view) }
    }
    
}

extension Style {
        
    static func addTitle(title: String, _ vc: UIViewController) {
        let titleLabel = UILabel.makeLargeText(title)
        titleLabel.textAlignment = .center
        vc.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(vc.view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    static func addBackButton(_ vc: UIViewController, action: @escaping (UIButton) -> Void) {
        let backButton = UIButton.makeImageButton(image: Images.Icons.back.image, action: action)
        backButton.tintColor = Colors.charcoal.color
        vc.view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalTo(vc.view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    static func addNotificationButton(_ vc: UIViewController, action: @escaping (UIButton) -> Void) {
        let backButton = UIButton.makeImageButton(image: Images.Icons.notification.image, action: action)
        backButton.tintColor = Colors.charcoal.color
        vc.view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalTo(vc.view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }

}
