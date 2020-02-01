//
//  Created by Vladimir on 1/29/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

final class StretchScrollDelegate: NSObject, UIScrollViewDelegate {
    
    private var userScrollInitiated: Bool = false
    
    private let view: UIView
    
    private let onViewPrefferedToBeAppeared: BoolClosure
    
    private let heightConstraint: NSLayoutConstraint
    
    init(view: UIView, onViewPrefferedToBeAppeared: @escaping BoolClosure) {
        self.view = view
        self.onViewPrefferedToBeAppeared = onViewPrefferedToBeAppeared
        self.heightConstraint = view.heightAnchor.constraint(equalToConstant: 150 + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0))
        self.heightConstraint.isActive = true
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        userScrollInitiated = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetYValue = scrollView.contentOffset.y
        let alphaValue = 1.0 - CGFloat(1.0 * CGFloat(scrollView.contentInset.top * CGFloat(CGFloat(scrollView.contentInset.top - abs(offsetYValue)) / 100.0 / 100.0)))
        if userScrollInitiated {
            if offsetYValue < 0 {
                if abs(scrollView.contentInset.top) - offsetYValue > 0{
                    view.alpha = alphaValue
                    UIView.animate(withDuration: 0.5) { [weak self] in
                        self?.onViewPrefferedToBeAppeared(alphaValue >= 0.3)
                    }
                }
                let stretchHeightValue = abs(offsetYValue) - scrollView.contentInset.top
                if stretchHeightValue > -30 {
                    heightConstraint.constant = stretchHeightValue + 150 + view.safeAreaInsets.top
                }
            } else {
                view.alpha = 0
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.onViewPrefferedToBeAppeared(false)
                }
            }
        }
    }
    
}
