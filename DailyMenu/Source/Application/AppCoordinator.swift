//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import Extensions
import Services

class AppCoordinator {
    
    let window: UIWindow
    
    private let tabBarController: UITabBarController = DailyTabBarController()
    
    private var notificationTokens: [Token]
    
    private let keychainService: KeychainService
    private let userDefaultsService: UserDefaultsService
    private let networkService: NetworkService
    
    init(_ window: UIWindow, keychainService: KeychainService, userDefaultsService: UserDefaultsService, networkService: NetworkService) {
        self.window = window
        
        self.keychainService = keychainService
        self.userDefaultsService = userDefaultsService
        self.networkService = networkService
        
        self.notificationTokens = []
    }
    
    func registerApplication() -> Bool {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        configureRootViewController()
        
        networkService.fetchUserData(onSuccess: { [weak self] user in
            guard let self = self else { return }
            if self.userDefaultsService.hasAddress {
                NotificationCenter.default.post(name: .userLoggedIn, object: nil)
            } else {
                NotificationCenter.default.post(name: .userInvalidAddress, object: nil)
            }
            }, onFailure: { [weak self] in
                self?.showGreeting()
        })
        
        notificationTokens.append(Token.make(descriptor: .userLoggedOutDescriptor, using: { [weak self] _ in
            self?.showGreeting()
        }))
        
        notificationTokens.append(Token.make(descriptor: .userInvalidAddress, using: { [weak self] _ in
            self?.showAddressCheckin()
        }))
        
        return true
    }
    
}

private extension AppCoordinator {
    
    func configureRootViewController() {
         let vc = SignUpViewController(viewModel: SignUpViewModelImplementation())
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
         tabBarController.viewControllers = [nav]
        
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
        vc.tabBarItem.image = Images.tabExploreInactive.image.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = Images.tabExploreActive.image.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = "Explore"
		vc.tabBarItem.setTitleTextAttributes([.font: FontFamily.extraSmallMedium!, .foregroundColor: Colors.blue.color], for: .normal)
        return NavigationController(rootViewController: vc)
    }
    
    var settingsTab: NavigationController {
        let vm = SettingsViewModelImplementation()
        let vc = SettingsViewController(viewModel: vm)
        vc.tabBarItem.image = Images.tabSettingsInactive.image.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = Images.tabSettingsActive.image.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = "Settings"
		vc.tabBarItem.setTitleTextAttributes([.font: FontFamily.extraSmallMedium!, .foregroundColor: Colors.blue.color], for: .normal)
        return NavigationController(rootViewController: vc)
    }
    
    var cartTab: NavigationController {
        let vc = CartViewController()
        vc.tabBarItem.image = Images.tabCartInactive.image.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = Images.tabCartActive.image.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.title = "Cart"
		vc.tabBarItem.setTitleTextAttributes([.font: FontFamily.extraSmallMedium!, .foregroundColor: Colors.blue.color], for: .normal)
        return NavigationController(rootViewController: vc)
    }
    
    func showGreeting() {
        let vm = GreetingViewModelImplementation()
        let vc = GreetingViewController(viewModel: vm)
        vc.modalPresentationStyle = .overCurrentContext
        window.rootViewController?.show(vc, sender: nil)
    }
    
    func showAddressCheckin() {
        let vm  = DeliveryLocationViewModelImplementation()
        let vc = DeliveryLocationViewController(viewModel: vm)
        vc.modalPresentationStyle = .overCurrentContext
        window.rootViewController?.show(vc, sender: nil)
    }
    
}
