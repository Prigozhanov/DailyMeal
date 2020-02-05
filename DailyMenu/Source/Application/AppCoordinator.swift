//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import Extensions
import Services

class AppCoordinator {
    
    let window: UIWindow
    
    private let tabBarController: UITabBarController = UITabBarController()
    
    private var notificationTokens: [Token]
    
    private let keychainService: KeychainService
    private let userDefaultsService: UserDefaultsService
    
    init(_ window: UIWindow, keychainService: KeychainService, userDefaultsService: UserDefaultsService) {
        self.window = window
        
        self.keychainService = keychainService
        self.userDefaultsService = userDefaultsService
        
        self.notificationTokens = []
    }
    
    func registerApplication() -> Bool {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        configureRootViewController()
        
        if userDefaultsService.getValueForKey(key: .id) == nil {
            showGreeting()
        }
        
        notificationTokens.append(Token.make(descriptor: .userLoggedOutDescriptor, using: { [weak self] _ in
            self?.showGreeting()
        }))
        
        return true
    }
    
}

private extension AppCoordinator {
    
    func configureRootViewController() {
//      let vc = AddCreditCardViewController(viewModel: AddCreditCardViewModelImplementation())
//      tabBarController.viewControllers = [vc]
        
        tabBarController.setViewControllers([
            cartTab,
            exploreTab,
            settingsTab
        ], animated: false)
        tabBarController.selectedIndex = 1
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
