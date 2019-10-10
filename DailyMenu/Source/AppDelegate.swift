//
//  AppDelegate.swift
//  daily-menu
//
//  Created by Vladimir on 9/26/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabbar = UITabBarController()
        tabbar.viewControllers = [
            cartTab,
            exploreTab,
            settingsTab
        ]

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = tabbar
        self.window!.makeKeyAndVisible()
        
        tabbar.show(GreetingViewController(viewModel: GreetingViewModelImplementation()), sender: nil)
        
        return true
    }
    
}

private extension AppDelegate {
    var exploreTab: UINavigationController {
          let vm = RestaurantsViewModelImplementation()
          let vc = RestaurantsViewController(viewModel: vm)
          vc.tabBarItem.image = #imageLiteral(resourceName: "Tab-Explore-Inactive")
          vc.tabBarItem.title = "Explore"
          return UINavigationController(rootViewController: vc)
      }
      
      var settingsTab: UINavigationController {
          let vm = SettingsViewModelImplementation()
          let vc = SettingsViewController(viewModel: vm)
          vc.tabBarItem.image = #imageLiteral(resourceName: "Tab-Settings-Inactive")
          vc.tabBarItem.title = "Settings"
          return UINavigationController(rootViewController: vc)
      }
      
      var cartTab: UINavigationController {
          let vm = CartViewModelImplementation()
          let vc = CartViewController(viewModel: vm)
          vc.tabBarItem.image = #imageLiteral(resourceName: "Tab-Cart-Inactive")
          vc.tabBarItem.title = "Cart"
          return UINavigationController(rootViewController: vc)
      }
}

