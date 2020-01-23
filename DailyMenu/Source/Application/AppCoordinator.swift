//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
    }
    
    func registerApplication() -> Bool {
        window.rootViewController = makeRootViewController()
        window.makeKeyAndVisible()
        
        //    showGreeting()
        
        return true
    }
    
}

private extension AppCoordinator {
    
    func makeRootViewController() -> UIViewController {
        let tabbar = UITabBarController()
        tabbar.viewControllers = [
            cartTab,
            exploreTab,
            settingsTab
        ]
        tabbar.selectedIndex = 1
        return tabbar
    }
    
    var exploreTab: NavigationController {
        let vm = RestaurantsViewModelImplementation()
        let vc = RestaurantsViewController(viewModel: vm)
        vc.tabBarItem.image = Images.tabExploreInactive.image
        vc.tabBarItem.title = "Explore"
        return NavigationController(rootViewController: vc)
    }
    
    var settingsTab: NavigationController {
        let vm = SettingsViewModelImplementation()
        let vc = SettingsViewController(viewModel: vm)
        vc.tabBarItem.image = Images.tabSettingsInactive.image
        vc.tabBarItem.title = "Settings"
        return NavigationController(rootViewController: vc)
    }
    
    var cartTab: NavigationController {
        let vc = CartViewController()
        vc.tabBarItem.image = Images.tabCartInactive.image
        vc.tabBarItem.title = "Cart"
        return NavigationController(rootViewController: vc)
    }
    
    func showGreeting() {
        let vm = GreetingViewModelImplementation()
        let vc = GreetingViewController(viewModel: vm)
        window.rootViewController?.show(vc, sender: nil)
    }
    
}
