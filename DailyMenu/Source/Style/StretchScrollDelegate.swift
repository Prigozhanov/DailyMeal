//
//  Created by Vladimir on 1/29/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import SnapKit

final class StretchScrollDelegate: NSObject, UIScrollViewDelegate {
    
    private var userScrollInitiated: Bool = false
    
    private let view: UIView
    
    private let onViewPrefferedToBeVisible: BoolClosure
    
    private var heightConstraint: Constraint?
    
    init(view: UIView, onViewPrefferedToBeVisible: @escaping BoolClosure) {
        self.view = view
        self.onViewPrefferedToBeVisible = onViewPrefferedToBeVisible
        
        guard let superview = view.superview else {
            return
        }
        
        let supportingLayoutGuide = UILayoutGuide()
        superview.addLayoutGuide(supportingLayoutGuide)
        supportingLayoutGuide.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(superview.safeAreaLayoutGuide.snp.top)
        }
        
        var heightConstraint: Constraint?
        view.snp.makeConstraints {
            heightConstraint = $0.height.equalTo(supportingLayoutGuide).offset(150).constraint
        }
        self.heightConstraint = heightConstraint
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        userScrollInitiated = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetYValue = scrollView.contentOffset.y
        let alphaValue = 1.0 - CGFloat(1.0 * CGFloat(scrollView.contentInset.top * CGFloat(CGFloat(scrollView.contentInset.top - abs(offsetYValue)) / 100.0 / 100.0)))
        if userScrollInitiated {
            if offsetYValue < 0 {
                if abs(scrollView.adjustedContentInset.top) - offsetYValue > 0 {
                    view.alpha = alphaValue
                    UIView.animate(withDuration: 0.5) { [weak self] in
                        self?.onViewPrefferedToBeVisible(alphaValue >= 0.3)
                    }
                }
                let stretchHeightValue = abs(offsetYValue) - scrollView.adjustedContentInset.top
                if stretchHeightValue > -30 {
                    heightConstraint?.update(offset: stretchHeightValue + 150)
                }
            } else {
                view.alpha = 0
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.onViewPrefferedToBeVisible(false)
                }
            }
        }
    }
    
}
