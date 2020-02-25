//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

extension UIApplication {
    
    static var topViewController: UIViewController? {
        return topViewController(UIApplication.shared.keyWindow?.rootViewController) ?? nil
    }
    
    private static func topViewController(_ vc: UIViewController?) -> UIViewController? {
        guard let presentingViewController = vc?.presentingViewController else {
            return vc
        }
        if let tabBarController = presentingViewController.presentingViewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
            return topViewController(selectedViewController)
            }
        } else if let navigationController = presentingViewController as? UINavigationController {
            if let visibleViewController = navigationController.visibleViewController {
            return visibleViewController
            }
        }
        return vc
    }
    
}
