//
//  Created by Timur Bernikovich on 6/7/19.
//  Copyright © 2019 Timur Bernikovich. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    private let alwaysPoppableDelegate = AlwaysPoppableDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alwaysPoppableDelegate.originalDelegate = interactivePopGestureRecognizer?.delegate
        alwaysPoppableDelegate.navigationController = self
        interactivePopGestureRecognizer?.delegate = alwaysPoppableDelegate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let presented = presentedViewController, !presented.isBeingDismissed {
            return presented.supportedInterfaceOrientations
        }
        
        return topViewController?.supportedInterfaceOrientations ?? [.portrait]
    }
    
}

private final class AlwaysPoppableDelegate: NSObject, UIGestureRecognizerDelegate {
    
    weak var navigationController: UINavigationController?
    weak var originalDelegate: UIGestureRecognizerDelegate?
    
    override func responds(to aSelector: Selector!) -> Bool {
        if aSelector == #selector(gestureRecognizer(_:shouldReceive:)) {
            return true
        } else if let responds = originalDelegate?.responds(to: aSelector) {
            return responds
        } else {
            return false
        }
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return originalDelegate
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let nav = navigationController, nav.isNavigationBarHidden, nav.viewControllers.count > 1 {
            return true
        } else if let result = originalDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) {
            return result
        } else {
            return false
        }
    }
    
}
